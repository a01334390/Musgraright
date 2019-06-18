//
//  FirebaseController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/17/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
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
}
