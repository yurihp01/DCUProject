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
    func addAnalyse(analyse: Analyse)
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
        self.projectRef.childByAutoId().setValue(project.toDict()) { [self] error, database in
            if error == nil {
                self.project?.id = database.key
                projectRef.child(database.key ?? "").setValue(self.project?.toDict())
            }
        }
    }
    
    func addAnalyse(analyse: Analyse) {
        analyseRef.setValue(try? DictionaryEncoder.encode(analyse))
    }
    
    func addUser(email: String) {
        let email = NSString(string: email)
        userRef.setValue(email)
    }
    
    func removeDots(text: String?) -> String {
        return text!.replacingOccurrences(of: ".", with: ",,")
    }
}

private extension FirebaseService {
//    func getData() async throws -> Any {
//        return await ref.observeSingleEventAndPreviousSiblingKey(of: .value)
//    }
}
