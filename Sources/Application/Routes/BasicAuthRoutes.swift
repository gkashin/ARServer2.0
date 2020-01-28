//
//  BasicAuthRoutes.swift
//  Application
//
//  Created by Георгий Кашин on 28.01.2020.
//

import Foundation
import KituraContracts
import LoggerAPI

func initializeBasicAuthRoutes(app: App) {
    app.router.get("/login/basic", handler: app.basicAuthLogin)
}

// MARK: - Basic Authentication
extension App {
    func basicAuthLogin(user: BasicAuth, respondWith: ([Object]?, RequestError?) -> Void) {
        Log.info("User \(user.id) logged in")
        let objects = [Object(id: 10, userId: 10, url: URL(string: "https://apple.com")!, date: Date())]
        respondWith(objects, nil)
    }
}
