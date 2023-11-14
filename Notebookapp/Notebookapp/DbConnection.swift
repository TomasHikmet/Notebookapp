//
//  DbConnection.swift
//  Notebookapp
//
//  Created by Tomas Hikmet on 2023-10-17.
//

import Foundation
import Firebase

class DbConnection: ObservableObject {
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    let USER_DATA_COLLECTION = "user_data"

    @Published var currentUserData: UserData?
    @Published var currentUser: User?
    
    var dbListener: ListenerRegistration?
    
    init() {
        
        auth.addStateDidChangeListener { auth, user in
            
            if let user = user {
                
                print("A user has logged in with email: \(user.email ?? "No Email")")
                
                self.currentUser = user
                
                self.startListeningToDb()
                
            } else {
                
                self.dbListener?.remove()
                self.dbListener = nil
                self.currentUserData = nil
                self.currentUser = nil
                print("User has logged out!")
                
            }
            
        }
        
    }
    
    func startListeningToDb() {
        
        guard let user = currentUser else {return}
        
        dbListener = db.collection(self.USER_DATA_COLLECTION).document(user.uid).addSnapshotListener {
            snapshot, error in
            
            if let error = error {
                print("Error occurred \(error.localizedDescription)")
                return
            }
            guard let documentSnapshot = snapshot else { return }
            
            let result = Result {
                try documentSnapshot.data(as: UserData.self)
            }
            
            switch result {
            case .success(let userData):
                self.currentUserData = userData
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
            
        }
        
    }
    
    func RegisterUser(email: String, password: String, birthdate: Date) -> Bool {
        
        var success = false
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                success = false
            }
            
            if let authResult = authResult {
                
                let newUserData = UserData(notes: [], birthdate: birthdate)
                
                do {
                    try self.db.collection(self.USER_DATA_COLLECTION).document(authResult.user.uid).setData(from: newUserData)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
                
                print("Account successfully created!")
                success = true
                
            }
            
        }
        
        return success
        
    }
    
    func LoginUser(email: String, password: String) -> Bool {
        
        var success = false
        
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            
            if error != nil {
                print("Error logging in!")
                success = false
            }
            
            if let _ = authDataResult {
                
                print("Successfully logged in!")
                success = true
            }
            
        }
        
        return success

    }
    
    func addnotesToDb(notes: Notes) {
        
        if let currentUser = currentUser {
            
            do {
                try db.collection(USER_DATA_COLLECTION).document(currentUser.uid).updateData(["notes": FieldValue.arrayUnion([Firestore.Encoder().encode(notes)])])
            } catch {
                
            }
        }
    }
}
