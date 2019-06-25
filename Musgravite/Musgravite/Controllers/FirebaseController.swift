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
    static func currentAuthenticatedUserMail() -> String {
        return "a@a.a"
    }
    
    static func logOut(){
        do{
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("An error happened: %@",error)
        }
    }
    
    //MARK: Firestore Methods
    
    static func getClassroomData(completionBlock: @escaping (_ success: [Salon]?) -> Void){
        Firestore.firestore().collection("salon").getDocuments(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                var salones:[Salon]?
                for document in querySnapshot!.documents {
                    let salon = Salon(document.documentID,
                                      document.data()["cursos"] as! [DocumentReference],
                                      document.data()["edificio"] as! String,
                                      document["numero"] as! Int,
                                      document["tipo"] as! Int)
                    if salones == nil {
                        salones = [salon]
                    } else {
                        salones!.append(salon)
                    }
                }
                completionBlock(salones)
            }
        })
    }
    
    static func getCourseData(_ curso: DocumentReference, completionBlock: @escaping (_ success: Curso?) -> Void) {
        Firestore.firestore().collection("cursos").document(curso.documentID).getDocument(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                if let document = querySnapshot {
                    let curso = Curso(document.documentID,
                                      document.data()!["nombre"] as! String,
                                      document.data()!["grupos"] as! [DocumentReference])
                    completionBlock(curso)
                } else {
                    completionBlock(nil)
                }
            }
        })
    }
    
    static func getGroupData(_ grupo:DocumentReference, completionBlock: @escaping (_ success: Grupo?) -> Void) {
        Firestore.firestore().collection("grupos").document(grupo.documentID).getDocument(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                let document = querySnapshot!.data()
                let grupo = Grupo(querySnapshot!.documentID,
                                  querySnapshot?.data()!["equipos"] as! [DocumentReference],
                                  document!["horaInicio"] as! Int,
                                  document!["duracion"] as! Int)
                completionBlock(grupo)
            }
        })
    }
    
    static func getTeamData(_ team:DocumentReference, completionBlock: @escaping(_ success: Equipo?) -> Void) {
        Firestore.firestore().collection("equipos").document(team.documentID).getDocument(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                let equipo = Equipo(querySnapshot!.documentID,
                                    querySnapshot?.data()!["nombre"] as! String,
                                    querySnapshot?.data()!["integrantes"] as! [String],
                                    querySnapshot?.data()!["proyectos"] as! [DocumentReference])
                completionBlock(equipo)
            }
        })
    }
    
    static func addTeamToGroup(_ team: Equipo,_ grupoID: String, completionBlock: @escaping(_ success: Bool) -> Void) {
        self.createNewTeam(team, completionBlock: ({(teamID) in
            if teamID != nil {
                let groupREF = Firestore.firestore().collection("grupos").document(grupoID)
                groupREF.updateData([
                    "equipos" : FieldValue.arrayUnion([teamID!])
                ]) { err in
                    if err != nil {
                        completionBlock(false)
                    } else {
                        completionBlock(true)
                    }
                }
            } else {
                completionBlock(false)
            }
        }))
    }
    
    private static func createNewTeam(_ team: Equipo, completionBlock: @escaping(_ success: DocumentReference?) -> Void){
        var ref:DocumentReference? = nil
        ref = Firestore.firestore().collection("equipos").addDocument(data: team.firestoreReady()) { err in
            if err != nil {
                completionBlock(nil)
            } else {
                completionBlock(ref)
            }
        }
    }
    
    static func addParticipantToTeam(_ teamID: String, _ participantID:String, completionBlock: @escaping(_ success: Bool) -> Void) {
        Firestore.firestore().collection("equipos").document(teamID).updateData([
            "integrantes" : FieldValue.arrayUnion([participantID])
        ]) { err in
            if err != nil {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    static func removeParticipantFromTeam(_ teamID: String, _ participantID:String, completionBlock: @escaping(_ success: Bool) -> Void){
        Firestore.firestore().collection("equipos").document(teamID).updateData(["integrantes" : FieldValue.arrayRemove([participantID])]) { err in
            if err != nil {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    static func addNewProjectToTeam(_ teamID:String,_ project: Proyecto, completionBlock: @escaping(_ success: Bool) -> Void) {
        self.createNewProject(teamID, project, completionBlock: ({(project) in
            if project == nil {
                completionBlock(false)
            } else {
                Firestore.firestore().collection("equipos").document(teamID).updateData(["proyectos":FieldValue.arrayUnion([project!])]) { err in
                    if err != nil {
                        completionBlock(false)
                    } else {
                        completionBlock(true)
                    }
                }
            }
        }))
    }
    
    static func removeProjectFromTeam(_ teamID:String,_ project: DocumentReference, completionBlock: @escaping(_ success: Bool) -> Void){
        //TODO: Do logic
    }
    
    private static func removeProject(_ projectID:String, completionBlock: @escaping(_ success: Bool) -> Void){
        //TODO: Do logic
    }
    
    private static func createNewProject(_ teamID:String,_ project: Proyecto, completionBlock: @escaping(_ success: DocumentReference?) -> Void){
        var ref:DocumentReference?
        ref = Firestore.firestore().collection("proyectos").addDocument(data: project.firestoreReady()) { err in
            if err != nil {
                completionBlock(nil)
            } else {
                completionBlock(ref)
            }
            
        }
    }
}


