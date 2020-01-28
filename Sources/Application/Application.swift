import Kitura
import KituraOpenAPI

public class App {

    let router = Router()

    public init() throws {}

    func postInit() throws {
        initializeBasicAuthRoutes(app: self)
        initializeORMRoutes(app: self)
        initializeSessionRoutes(app: self)
        KituraOpenAPI.addEndpoints(to: router)
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.run()
    }
}
