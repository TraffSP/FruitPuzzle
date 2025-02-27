//
//  AuthCore.swift
//  FruitPuzzle
//
//  Created by muser on 24.02.2025.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

protocol AuthCoreProtocol {
    var isFormValid: Bool { get }
}

@MainActor
class AuthCore: ObservableObject {
    @Published var text: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentuser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signInAnonymously() async {
        do {
            let result = try await Auth.auth().signInAnonymously()
            self.userSession = result.user
            print("Signed in anonymously as user: \(String(describing: result.user.uid))")
        } catch {
            text = "Error signing in anonymously: \(error.localizedDescription)"
            print("Error signing in anonymously: \(error.localizedDescription)")
        }
    }
    
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            text = "Error login: \(error.localizedDescription)"
            print("Error login: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            let user = User(id: result.user.uid, name: name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            print("User saved: \(user)")
            await fetchUser()
        } catch {
            text = "Error create user: \(error.localizedDescription)"
            print(error.localizedDescription)
        }
    }
    
    func deleteUserAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "UserErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user is currently signed in."])))
            return
        }
        
        user.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentuser = nil
        } catch {
            text = "Error signout: \(error.localizedDescription)"
            print("Error signout: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentuser = try snapshot.data(as: User.self)
            print("Fetched User: \(String(describing: self.currentuser))")
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
    }
}
