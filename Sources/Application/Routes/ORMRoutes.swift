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
    
    // Initiallize User routes
    app.router.post("/user", handler: app.createUser)
    app.router.get("/users/all", handler: app.findUsers)
    app.router.put("/user", handler: app.updateUser)
    app.router.delete("/user", handler: app.removeUser)
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
