//
//  Firebase.swift
//  DCUProject
//
//  Created by PRO on 16/02/2022.
//

import Firebase
import FirebaseDatabase

typealias Handle = AuthStateDidChangeListenerHandle

protocol FirebaseServiceProtocol: AnyObject {
    var handle: Handle { get }
    var currentUser: Firebase.User? { get }
    var project: Project? { get set }
    func removeHandle(handle: Handle)
    func login(email: String, password: String) async -> String
    func register(email: String, password: String) async -> String
    func getProjects() async -> [Project]
    func addAnalyse(analyse: Analyse, onCompletion: @escaping (String) -> ())
    func addPreAvaliation(preAvaliation: PreAvaliation, onCompletion: @escaping (String) -> ())
    func addProject(project: Project)
    func addUser(email: String)
}

class FirebaseService: FirebaseServiceProtocol {
    var project: Project?
    
    var currentUser: Firebase.User? {
        return Auth.auth().currentUser
    }
    
    var handle: Handle {
        return Auth.auth().addStateDidChangeListener { auth, user in }
    }
    
    var userRef: DatabaseReference {
        Database.database().reference(withPath: "user")
    }
    
    var projectRef: DatabaseReference {
        userRef.database.reference(withPath: "project")
    }
    
    var analyseRef: DatabaseReference {
        projectRef.database.reference(withPath: "analyse")
    }
    
    func removeHandle(handle: Handle) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func login(email: String, password: String) async -> String {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return "Logado com sucesso!"
        } catch {
            return error.localizedDescription
        }
    }
    
    func register(email: String, password: String) async -> String {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            addUser(email: email)
            return "Usuário criado com sucesso!"
        } catch {
            return error.localizedDescription
        }
    }
    
    func getProjects() async -> [Project] {
        do {
//            try await 
        }
        return []
    }
    
    func addProject(project: Project) {
        self.project = project
        self.projectRef.childByAutoId().setValue(project.toDict()) { [weak self] error, database in
            if error == nil {
                self?.project?.id = database.key
                self?.projectRef.child(database.key ?? "").setValue(self?.project?.toDict())
            }
        }
    }
    
    func addAnalyse(analyse: Analyse, onCompletion: @escaping (String) -> ()) {
        self.projectRef.childByAutoId().setValue(project?.toDict()) { [weak self] error, database in
            if error == nil {
                self?.project?.id = database.key
                self?.projectRef.child(database.key ?? "").setValue(self?.project?.toDict())
                self?.project?.analysis.append(analyse)
                onCompletion("Análise adicionada com sucesso!")
            } else {
                onCompletion(error?.localizedDescription ?? "")
            }
        }
    }
    
    func addPreAvaliation(preAvaliation: PreAvaliation, onCompletion: @escaping (String) -> ()) {
        self.projectRef.childByAutoId().setValue(project?.toDict()) { [weak self] error, database in
            if error == nil {
                self?.project?.id = database.key
                self?.projectRef.child(database.key ?? "").setValue(self?.project?.toDict())
                self?.project?.preAvaliation = preAvaliation
                onCompletion("Pré-Avaliação adicionada com sucesso!")
            } else {
                onCompletion(error?.localizedDescription ?? "")
            }
        }
    }
    
    func addUser(email: String) {
        let email = NSString(string: email)
        userRef.setValue(email)
    }
}

private extension FirebaseService {
//    func getData() async throws -> Any {
//        return await ref.observeSingleEventAndPreviousSiblingKey(of: .value)
//    }
}
