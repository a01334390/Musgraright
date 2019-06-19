//
//  FirebaseController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/17/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Firebase
import FirebaseFirestore

class FirebaseController {
    
    //MARK: Authentication methods
    static func signUp(_ email:String,_ password:String, completionBlock: @escaping (_ success: Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    static func signIn(_ email:String,_ password:String, completionBlock: @escaping (_ success: Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    static func userIsRegistered(_ email:String, completionBlock: @escaping (_ success: Bool) -> Void){
        Auth.auth().fetchProviders(forEmail: email) { (providers, error) in
            if error != nil {
                completionBlock(false)
            } else if let providers = providers {
                print(providers)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    static func userIsLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func logOut(){
        do{
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("An error happened: %@",error)
        }
    }
    
    //MARK: Firestore Methods
    
    static func getCoursesData(completionBlock: @escaping (_ success: [Curso]?) -> Void) {
        Firestore.firestore().collection("cursos").getDocuments(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                var cursos:[Curso]?
                for document in querySnapshot!.documents {
                    let curso = Curso(document.documentID,
                                      document.data()["nombre"] as! String,
                                      document.data()["grupos"] as! DocumentReference,
                                      (document.data()["salon"]! as! NSString).integerValue,
                                      document.data()["edificio"] as! String)
                    if cursos == nil {
                        cursos = [curso]
                    } else {
                        cursos!.append(curso)
                    }
                }
                completionBlock(cursos)
            }
        })
    }
    
}
