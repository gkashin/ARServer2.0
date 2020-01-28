//
//  SessionRoutes.swift
//  ARServer2.0
//
//  Created by Георгий Кашин on 28.01.2020.
//

import Kitura
import KituraContracts

func initializeSessionRoutes(app: App) {
    app.router.get("/session", handler: app.getSessionHandler)
    app.router.post("/session", handler: app.postSessionHandler)
}

// MARK: - Session Routes
extension App {
    func getSessionHandler(session: Session, completion: @escaping ([Object]?, RequestError?) -> Void) {
        completion(session.objects, nil)
    }
    
    func postSessionHandler(session: Session, object: Object, completion: @escaping (Object?, RequestError?) -> Void) {
        session.objects.append(object)
        session.save()
        completion(object, nil)
    }
}
