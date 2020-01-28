import KituraContracts
import LoggerAPI
import SwiftKueryORM
import SwiftKueryMySQL

func initializeORMRoutes(app: App) {
    // Initialize MySQL Database
    let pool = MySQLConnection.createPool(
        host: "49.12.2.201",
        user: "aruser",
        password: "arpassword",
        database: "ardb",
        port: 3306,
        poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50)
    )
    Database.default = Database(pool)
    
    // Create tables if they do not exist
    do {
        try Object.createTableSync()
        try Token.createTableSync()
        try User.createTableSync()
        
        Log.info("All tables created")
    } catch {
        Log.error("Failed to create table: \(error)")
    }
    
    // Initialize Object routes
    app.router.post("/object", handler: app.createObject)
    app.router.get("/objects/all", handler: app.findObjects)
    app.router.get("/objects/user", handler: app.findObjectsForUser(userId:completion:))
    app.router.put("/object", handler: app.updateObject)
    app.router.delete("/object", handler: app.removeObject)
    
    // Initialize User routes
    app.router.post("/user", handler: app.createUser)
    app.router.get("/users/all", handler: app.findUsers)
    app.router.put("/user", handler: app.updateUser)
    app.router.delete("/user", handler: app.removeUser)
}

// MARK: - Object Routes
extension App {
    func createObject(object: Object, completion: @escaping (Object?, RequestError?) -> Void) {
        object.save(completion)
    }
    
    func findObjects(completion: @escaping ([Object]?, RequestError?) -> Void) {
        Object.findAll(completion)
    }
    
    func findObjectsForUser(userId: Int, completion: @escaping ([Object]?, RequestError?) -> Void) {
        Object.findAllForUser(id: userId, completion: completion)
    }
    
    func removeObject(id: Int, completion: @escaping (RequestError?) -> Void) {
        Object.delete(id: id, completion)
    }
    
    func updateObject(id: Int, object: Object, completion: @escaping (Object?, RequestError?) -> Void) {
        guard let objectId = object.id, id == objectId else {
            completion(nil, .notFound)
            return
        }
        object.update(id: id, completion)
    }
}

// MARK: - User Routes
extension App {
    func createUser(user: User, completion: @escaping (User?, RequestError?) -> Void) {
        user.save(completion)
    }
    
    func findUsers(completion: @escaping ([User]?, RequestError?) -> Void) {
        User.findAll(completion)
    }
    
    func removeUser(id: Int, completion: @escaping (RequestError?) -> Void) {
        User.delete(id: id, completion)
    }
    
    func updateUser(id: Int, user: User, completion: @escaping (User?, RequestError?) -> Void) {
        guard let userId = user.id, userId == id else {
            completion(nil, .notFound)
            return
        }
        user.update(id: id, completion)
    }
}
