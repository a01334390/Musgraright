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
        return Auth.auth().currentUser?.email ?? ""
    }
    
    static func logOut(){
        do{
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("An error happened: %@",error)
        }
    }
    
    //MARK: Firestore GET Methods
    
    static func getClassData(_ classroomID:String,completionBlock: @escaping (_ success: Salon?) -> Void){
        Firestore.firestore().collection("salon").document(classroomID).getDocument(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            }
            if let document = querySnapshot {
                var contentelems:[ContentElement] = []
                
                if let name = document.data()!["nombre"] {
                    let contel = ContentElement(posterImage: document.data()!["posterImage"] as! String,
                                                    classroomName: name as! String,
                                                    building: document.data()!["edificio"] as! String,
                                                    buildnumb: document["numero"] as! Int)
                        contentelems.append(contel)

                }
                
                if let imageArray = document.data()!["imagenes"] {
                    if let panonoImage = document.data()!["imagen360"] {
                        let contel = ContentElement(images: imageArray as! [String],
                                                    image360: panonoImage as! String)
                        contentelems.append(contel)
                    } else {
                        let contel = ContentElement(images: imageArray as! [String])
                        contentelems.append(contel)
                    }
                }
                
                if let videoArray = document.data()!["videos"] {
                    let contel = ContentElement(videos: videoArray as! [String])
                    contentelems.append(contel)
                }
                
                if let documentArray = document.data()!["documentos"] {
                    let contel = ContentElement(documents: documentArray as! [String])
                    contentelems.append(contel)
                }
                
                let salon = Salon(document.documentID,
                                  document.data()!["nombre"] as! String,
                                  document.data()!["cursos"] as! [DocumentReference],
                                  document.data()!["edificio"] as! String,
                                  document["numero"] as! Int,
                                  document["tipo"] as! Int,
                                  contentelems)
                completionBlock(salon)
            }
        })
    }
    
    static func getClassroomData(completionBlock: @escaping (_ success: [Salon]?) -> Void){
        Firestore.firestore().collection("salon").getDocuments(completion: {(querySnapshot,error) in
            print(querySnapshot)
            if error != nil {
                completionBlock(nil)
            } else {
                var salones:[Salon]?
                for document in querySnapshot!.documents {
                    var contentelems:[ContentElement] = []
                    
                    if let name = document.data()["nombre"] {
                            let contel = ContentElement(posterImage: document.data()["posterImage"] as! String,
                                                        classroomName: name as! String,
                                                        building: document.data()["edificio"] as! String,
                                                        buildnumb: document["numero"] as! Int)
                            contentelems.append(contel)

                    }
                    
                    if let imageArray = document.data()["imagenes"] {
                        if let panonoImage = document.data()["imagen360"] {
                            let contel = ContentElement(images: imageArray as! [String],
                                                        image360: panonoImage as! String)
                            contentelems.append(contel)
                        } else {
                            let contel = ContentElement(images: imageArray as! [String])
                            contentelems.append(contel)
                        }
                    }
                    
                    if let videoArray = document.data()["videos"] {
                        let contel = ContentElement(videos: videoArray as! [String])
                        contentelems.append(contel)
                    }
                    
                    if let documentArray = document.data()["documentos"] {
                        let contel = ContentElement(documents: documentArray as! [String])
                        contentelems.append(contel)
                    }
                    
                    let salon = Salon(document.documentID,
                                      document.data()["nombre"] as! String,
                                      document.data()["cursos"] as! [DocumentReference],
                                      document.data()["edificio"] as! String,
                                      document["numero"] as! Int,
                                      document["tipo"] as! Int,
                                      contentelems)
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
    
    static func getCourseData(_ cursoId: String, completionBlock: @escaping (_ success: Curso?) -> Void) {
        Firestore.firestore().collection("curso").document(cursoId).getDocument(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                print(querySnapshot!.data()!["nombre"] as! String)
                let curso = Curso(querySnapshot!.documentID,
                                      querySnapshot!.data()!["nombre"] as! String,
                                      querySnapshot!.data()!["nombreProfesor"] as! String,
                                      querySnapshot!.data()!["semestre"] as! String,
                                      querySnapshot!.data()!["grupos"] as! [DocumentReference],
                                      querySnapshot!.data()!["salones"] as! [DocumentReference])
                    completionBlock(curso)
                
            }
        })
    }
    
    static func getGroupData(_ grupoId:String, completionBlock: @escaping (_ success: Grupo?) -> Void) {
        Firestore.firestore().collection("grupo").document(grupoId).getDocument(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                let document = querySnapshot!.data()
                let grupo = Grupo(querySnapshot!.documentID,
                                  document!["equipos"] as! [DocumentReference],
                                  document!["estudiantes"] as! [DocumentReference],
                                  document!["proyecto"] as! DocumentReference,
                                  document!["horaInicio"] as! Int,
                                  document!["duracion"] as! Int,
                                  document!["numero"] as! Int,
                                  document!["salon"] as! DocumentReference)
                completionBlock(grupo)
            }
        })
    }
    
    static func getGroupsInCourse(_ grupos:[String], completionBlock: @escaping (_ success: [Grupo]?) -> Void){
        var returnGrupo:[Grupo]?
        for grupo in grupos {
            self.getGroupData(grupo, completionBlock: ({(retrievedGrupo) in
                if retrievedGrupo != nil {
                    if returnGrupo == nil {
                        returnGrupo = [retrievedGrupo!]
                    } else {
                        returnGrupo?.append(retrievedGrupo!)
                    }
                    if returnGrupo!.count == grupos.count {
                        completionBlock(returnGrupo)
                    }
                } else {
                    completionBlock(nil)
                }
            }))
        }
    }
    
    static func getStudentsInCourse(_ estudiantes:[DocumentReference], completionBlock: @escaping (_ success: [Estudiante]?) -> Void){
        var returnStudents:[Estudiante]?
        for estudiante in estudiantes {
            self.getStudentData(studentReference: estudiante, completionBlock: ({(retrievedStudent) in
                if retrievedStudent != nil {
                    if returnStudents == nil {
                        returnStudents = [retrievedStudent!]
                    } else {
                        returnStudents?.append(retrievedStudent!)
                    }
                } else {
                    completionBlock(nil)
                }
                
                if estudiantes.count == returnStudents?.count {
                    completionBlock(returnStudents)
                }
            }))
        }
    }
    
    
    
    static func getTeamsInCourse(_ equipos:[DocumentReference], completionBlock: @escaping (_ success: [Equipo]?) -> Void){
        var returnTeams:[Equipo]?
        for equipo in equipos {
            self.getTeamData(equipo, completionBlock: ({(retrievedTeam) in
                if retrievedTeam != nil{
                    if returnTeams == nil {
                        returnTeams = [retrievedTeam!]
                    } else {
                        returnTeams?.append(retrievedTeam!)
                    }
                } else{
                    completionBlock(nil)
                }
                
                if returnTeams?.count == equipos.count {
                    completionBlock(returnTeams)
                }
            }))
        }
        
    }
    
    static func getTasksInProject(_ tareas:[DocumentReference], completionBlock: @escaping (_ success: [Tarea]?) -> Void ){
        var returnTasks:[Tarea]?
        for tarea in tareas {
            self.getTareaData(tarea, completionBlock: ({(retrievedTarea) in
                if retrievedTarea != nil {
                    if returnTasks == nil {
                        returnTasks = [retrievedTarea!]
                    } else {
                        returnTasks?.append(retrievedTarea!)
                    }
                    completionBlock(returnTasks)
                } else {
                    completionBlock(nil)
                }
            }))
        }
    }
    
    static func getTeamData(_ team:DocumentReference, completionBlock: @escaping(_ success: Equipo?) -> Void) {
        Firestore.firestore().collection("equipo").document(team.documentID).getDocument(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                let equipo = Equipo(querySnapshot!.documentID,
                                    querySnapshot?.data()!["nombre"] as! String,
                                    querySnapshot?.data()!["integrantes"] as! [DocumentReference],
                                    querySnapshot?.data()!["proyectos"] as! [DocumentReference])
                completionBlock(equipo)
            }
        })
    }
    
    static func getStudentData(studentID:String, completionBlock: @escaping(_ success: Estudiante?) -> Void){
        Firestore.firestore().collection("estudiante").document(studentID).getDocument(completion: {(querySnapshot, error) in
            if error != nil {
                completionBlock(nil)
            } else {
                let estudiante = Estudiante(querySnapshot!.documentID,
                                            querySnapshot?.data()!["mail"] as! String,
                                            querySnapshot?.data()!["nombre"] as! String,
                                            querySnapshot?.data()!["apellidos"] as! String,
                                            querySnapshot?.data()!["matricula"] as! String,
                                            querySnapshot?.data()!["equipos"] as! [DocumentReference],
                                            querySnapshot?.data()!["proyectos"] as! [DocumentReference],
                                            querySnapshot?.data()!["grupos"] as! [DocumentReference],
                                            querySnapshot?.data()!["tareas"] as! [DocumentReference],
                                            querySnapshot?.data()!["cursos"] as! [DocumentReference]
                                            )
                completionBlock(estudiante)
            }
        })
    }
    
    static func getStudentData(studentReference:DocumentReference, completionBlock: @escaping(_ success: Estudiante?) -> Void){
        Firestore.firestore().collection("estudiante").document(studentReference.documentID).getDocument(completion: {(querySnapshot, error) in
            if error != nil {
                completionBlock(nil)
            } else {
                let estudiante = Estudiante(querySnapshot!.documentID,
                                            querySnapshot?.data()!["mail"] as! String,
                                            querySnapshot?.data()!["nombre"] as! String,
                                            querySnapshot?.data()!["apellidos"] as! String,
                                            querySnapshot?.data()!["matricula"] as! String,
                                            querySnapshot?.data()!["equipos"] as! [DocumentReference],
                                            querySnapshot?.data()!["proyectos"] as! [DocumentReference],
                                            querySnapshot?.data()!["grupos"] as! [DocumentReference],
                                            querySnapshot?.data()!["tareas"] as! [DocumentReference],
                                            querySnapshot?.data()!["cursos"] as! [DocumentReference])
                completionBlock(estudiante)
            }
        })
    }
    
    static func getTareaData(_ tarea:DocumentReference, completionBlock: @escaping(_ success: Tarea?) -> Void){
        Firestore.firestore().collection("tareas").document(tarea.documentID).getDocument(completion: {(querySnapshot,error) in
            if error != nil {
                completionBlock(nil)
            } else {
                let tarea = Tarea(querySnapshot!.documentID,
                                  querySnapshot?.data()!["nombre"] as! String,
                                   querySnapshot?.data()!["descripcion"] as! String,
                                   (querySnapshot?.data()!["fechaInicio"] as! Timestamp).dateValue(),
                                   (querySnapshot?.data()!["fechaFin"] as! Timestamp).dateValue(),
                                   querySnapshot?.data()!["fase"] as! String,
                                   querySnapshot?.data()!["status"] as! String,
                                querySnapshot?.data()!["responsable"] as! DocumentReference)
                completionBlock(tarea)
            }
        })
    }
    
    static func getTareasData(_ tareas:[DocumentReference], completionBlock: @escaping(_ success: [Tarea]?) -> Void){
        var tareasToStore:[Tarea]?
        for tarea in tareas {
            Firestore.firestore().collection("tareas").document(tarea.documentID).getDocument(completion: {(querySnapshot,error) in
                if error != nil {
                    completionBlock(nil)
                } else {
                    let tareax = Tarea(querySnapshot!.documentID,
                                      querySnapshot?.data()!["nombre"] as! String,
                                       querySnapshot?.data()!["descripcion"] as! String,
                                       (querySnapshot?.data()!["fechaInicio"] as! Timestamp).dateValue(),
                                       (querySnapshot?.data()!["fechaFin"] as! Timestamp).dateValue(),
                                       querySnapshot?.data()!["fase"] as! String,
                                       querySnapshot?.data()!["status"] as! String,
                                    querySnapshot?.data()!["responsable"] as! DocumentReference)
                    if tareasToStore == nil {
                        tareasToStore = [tareax]
                    } else {
                        tareasToStore!.append(tareax)
                    }
                    
                    if tarea.isEqual(tareas.last!) {
                        completionBlock(tareasToStore)
                    }
                }
            })
        }
       }
    
    static func getProyectoData(_ proyecto: DocumentReference,completionBlock: @escaping(_ success: Proyecto?) -> Void){
        Firestore.firestore().collection("proyectos").document(proyecto.documentID).getDocument(completion: {(querySnapshot,error) in
                   if error != nil {
                       completionBlock(nil)
                   } else {
                    let proyecto = Proyecto(querySnapshot!.documentID,
                                            querySnapshot?.data()!["nombre"] as! String,
                                            querySnapshot?.data()!["metodologia"] as Any,
                                            querySnapshot?.data()!["fase"] as Any,
                                            querySnapshot?.data()!["descripcion"] as! String,
                                            querySnapshot?.data()!["tareas"] as! [DocumentReference])
                    completionBlock(proyecto)
                   }
               })
    }
    
    //MARK: Firestore PUT Methods
    
    static func addTeamToGroup(_ team: Equipo,_ grupoID: String, completionBlock: @escaping(_ success: Bool) -> Void) {
        self.createNewTeam(team, completionBlock: ({(teamID) in
            if teamID != nil {
                let groupREF = Firestore.firestore().collection("grupo").document(grupoID)
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
        ref = Firestore.firestore().collection("equipo").addDocument(data: team.firestoreReady()) { err in
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
    
    // MARK: Firestore Update Methods
    
    static func changeTaskStatus(_ taskID:String,_ taskStatus:String, completionBlock: @escaping(_ success: Bool) -> Void){
        Firestore.firestore().collection("tareas").document(taskID).updateData(["status": taskStatus]) { err in
            if err != nil {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    static func changeTaskResponsible(taskID:String,_ taskResponsible: DocumentReference, completionBlock: @escaping(_ success: Bool) -> Void) {
        Firestore.firestore().collection("tareas").document(taskID).updateData(["responsable": taskResponsible.documentID]) { err in
            if err != nil {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
}


