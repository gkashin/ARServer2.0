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

extension Object: Model {
    public static func findAllForUser(id: Int, completion: @escaping ([Object]?, RequestError?) -> Void) {
        let objects: Table
        
        do {
            objects = try Object.getTable()
        } catch {
            Log.error(error.localizedDescription)
            completion(nil, .internalServerError)
            return
        }
        
        let query = Select(from: objects).where("userId = ?")
        Object.executeQuery(query: query, parameters: [id], completion)
    }
}
