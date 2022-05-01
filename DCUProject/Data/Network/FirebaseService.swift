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
    func uploadMedia(name: String, image: UIImage, completion: @escaping (Result<String, FirebaseError>) -> ())
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
    
    let storageRef = Storage.storage(url: "gs://dcu-project-25b74.appspot.com").reference().child("images")

    func removeHandle(handle: Handle) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func login(email: String, password: String) async -> String {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return "Logado com sucesso!"
        } catch let error {
            return error.localizedDescription
        }
    }
    
    func register(email: String, password: String) async -> String {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            return "Usuário criado com sucesso!"
        } catch {
            return "Erro ao cadastrar usuário. Verifique a sua internet e tente novamente."
        }
    }
    
    func getProjects(_ onCompletion: @escaping ([Project]) -> ()) {
        let ref = projectRef.queryOrdered(byChild: "owner").queryEqual(toValue : currentUser?.email)
            ref.observeSingleEvent(of: .value, with: { snapshot in
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
            onCompletion(.failure(.notAdded))
        }
    }
    
    func updateProject(project: Project, onCompletion: @escaping (Result<String, FirebaseError>) -> ()) {
        self.projectRef.updateChildValues([project.id ?? "":project.toDict()]) { error, _ in
            if error == nil {
                onCompletion(.success("Projeto atualizado com sucesso"))
                return
            }
            onCompletion(.failure(.notUpdated))
        }
    }
    
    func uploadMedia(name: String, image: UIImage, completion: @escaping (Result<String, FirebaseError>) -> ()) {
        let nameRef = storageRef.child(name)
        if let uploadData = image.jpegData(compressionQuality: 0.5) {
            nameRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(.failure(.internetConnection))
                } else {
                    nameRef.downloadURL(completion: { (url, error) in
                        completion(.success(url?.absoluteString ?? ""))
                    })
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
