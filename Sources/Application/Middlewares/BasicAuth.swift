//
//  BasicAuth.swift
//  Application
//
//  Created by Георгий Кашин on 28.01.2020.
//

import CredentialsHTTP
import Foundation
import Kitura
import KituraContracts
import LoggerAPI
import SwiftKueryORM
import SwiftKueryMySQL

public struct BasicAuth: TypeSafeHTTPBasic {
    public static let authenticate = ["user": "password"]
    public static let isAdmin = true
    
    public static func verifyPassword(username: String, password: String, callback: @escaping (BasicAuth?) -> Void) {
        
//        var users = [User]()
//            User.findAll { fetchedUsers, error in
//                if error != nil {
//                    print("ERROR", error?.localizedDescription)
//                    //                return
//                }
//                guard let fetchedUsers = fetchedUsers else { return }
//                users = fetchedUsers
//            }
//        }
//        print(users)
        
        if
            let storedPassword = authenticate[username],
            storedPassword == password
        {
            callback(BasicAuth(id: username, isAdmin: isAdmin))
        } else {
            callback(nil)
        }
    }
    
    public var id: String
    public var isAdmin: Bool
}
