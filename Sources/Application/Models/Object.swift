import Foundation
import LoggerAPI
import SwiftKuery
import SwiftKueryORM

struct Object: Codable {
    let id: Int?
    let userId: Int
    let url: URL
    let date: Date
}

extension Object: Model {}
