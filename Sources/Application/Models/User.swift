import Foundation
import LoggerAPI
import SwiftKuery
import SwiftKueryORM

struct User: Codable {
    let id: Int?
    let username: String
    let password: String?
    let salt: String?
    let isAdmin: Bool
}

extension User: Model {}
