//
//  Firebase.swift
//  DCUProject
//
//  Created by PRO on 16/02/2022.
//

import Firebase
import FirebaseDatabase
import FirebaseStorage

typealias Handle = AuthStateDidChangeListenerHandle

protocol FirebaseServiceProtocol: AnyObject {
    var handle: Handle { get }
    var currentUser: Firebase.User? { get }
    var project: Project? { get set }
    func removeHandle(handle: Handle)
    func login(email: String, password: String) async -> String
    func register(email: String, password: String) async -> String
    func getProjects(_ onCompletion: @escaping ([Project]) -> ())
    func getProjectsAsInvite(_ onCompletion: @escaping ([Project]) -> ())
    func addProject(project: Project, onCompletion: @escaping (Result<Project, FirebaseError>) -> ())
    func updateProject(project: Project, onCompletion: @escaping (Result<String, FirebaseError>) -> ())
    func addImage(name: String, image: UIImage, completion: @escaping (Result<String, FirebaseError>) -> ())
}

class FirebaseService: FirebaseServiceProtocol {
    var project: Project?
    
    var currentUser: Firebase.User? {
        return Auth.auth().currentUser
    }
    
    var handle: Handle {
        return Auth.auth().addStateDidChangeListener { auth, user in }
    }
    
    var projectRef: DatabaseReference {
        Database.database().reference(withPath: "project")
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
            return "Usuário criado com sucesso!"
        } catch {
            return error.localizedDescription
        }
    }
    
    func getProjects(_ onCompletion: @escaping ([Project]) -> ()) {
        let ref = projectRef.queryOrdered(byChild: "owner").queryEqual(toValue : currentUser?.email)
            ref.observeSingleEvent(of: .value, with: { snapshot in
                // Get user value
                
                let data = snapshot.value as? Dictionary<String, Any> ?? Dictionary()
                
                let projects = data.values.compactMap { value -> Project? in
                    if let dict = value as? Dictionary<String, Any> {
                        return try? Project(dictionary: dict)
                    }
                    return nil
                }
                onCompletion(projects)
            })
    }
    
    func getProjectsAsInvite(_ onCompletion: @escaping ([Project]) -> ()) {
        let ref = projectRef.queryOrdered(byChild: "users")
            ref.observeSingleEvent(of: .value, with: { snapshot in
                // Get user value
                
                let data = snapshot.value as? Dictionary<String, Any> ?? Dictionary()
                
                let projects = data.values.compactMap { value -> Project? in
                    if let dict = value as? Dictionary<String, Any> {
                        return try? Project(dictionary: dict)
                    }
                    return nil
                }.filter { $0.users.contains(self.currentUser?.email ?? "") }
                onCompletion(projects)
            })
    }
    
    func addProject(project: Project, onCompletion: @escaping (Result<Project, FirebaseError>) -> ()) {
        self.project = project
        self.projectRef.childByAutoId().setValue(project.toDict()) { [weak self] error, database in
            guard let self = self,
                  var project = self.project else { return }
            if error == nil {
                project.id = database.key
                self.projectRef.child(database.key ?? "").setValue(project.toDict())
                onCompletion(.success(project))
                return
            }
            onCompletion(.failure(.notFound))
        }
    }
    
    func updateProject(project: Project, onCompletion: @escaping (Result<String, FirebaseError>) -> ()) {
        self.projectRef.updateChildValues([project.id ?? "":project.toDict()]) { error, _ in
            if error == nil {
                onCompletion(.success("Projeto atualizado com sucesso"))
                return
            }
            onCompletion(.failure(.notFound))
        }
    }
    
    func addPreAvaliation(preAvaliation: PreAvaliation, onCompletion: @escaping (String) -> ()) {
        self.projectRef.child(project?.id ?? "").setValue(project?.toDict()) { [weak self] error, database in
            if error == nil {
                self?.project?.id = database.key
                self?.project?.preAvaliation = preAvaliation
                self?.projectRef.child(database.key ?? "").setValue(self?.project?.toDict())
                onCompletion("Pré-Avaliação adicionada com sucesso!")
            } else {
                onCompletion(error?.localizedDescription ?? "")
            }
        }
    }
    
    func addAvaliation(avaliation: Avaliation, onCompletion: @escaping (String) -> ()) {
        self.projectRef.child(project?.id ?? "").setValue(project?.toDict()) { [weak self] error, database in
            if error == nil {
                self?.project?.id = database.key
                self?.project?.avaliations.append(avaliation)
                self?.projectRef.child(database.key ?? "").setValue(self?.project?.toDict())
                onCompletion("Avaliação adicionada com sucesso!")
            } else {
                onCompletion(error?.localizedDescription ?? "")
            }
        }
    }
    
    func addImage(name: String, image: UIImage, completion: @escaping (Result<String, FirebaseError>) -> ()) {
        let storageRef = Storage.storage().reference().child(name)
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    completion(.failure(.notFound))
                } else if let photoUrl = metadata?.path {
                    completion(.success(photoUrl))
                }
            }
        }
    }
    
    
}


extension Decodable {
    func parseDictionary<T>(with dictionary: Dictionary<String, Any>, to object: T.Type) throws -> T where T : Decodable {
        let json = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(object, from: json)
    }
}
