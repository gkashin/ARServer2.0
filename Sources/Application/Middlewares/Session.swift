//
//  Session.swift
//  Application
//
//  Created by Георгий Кашин on 28.01.2020.
//

import KituraSession

final class Session: TypeSafeSession {
    var sessionId: String
    var objects: [Object]
    
    init(sessionId: String) {
        self.sessionId = sessionId
        objects = []
    }
}

extension Session {
    static var store: Store?
    
    static var sessionCookie: SessionCookie = SessionCookie(name: "UserObjects", secret: "Secret key to encrypt cookie")
}
