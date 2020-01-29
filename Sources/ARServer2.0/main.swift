import Application
import LoggerAPI
import HeliumLogger

import KituraContracts
import SwiftKueryORM
import SwiftKueryMySQL

HeliumLogger.use(.debug)

do {
    let app = try App()
    try app.run()
} catch let error {
    Log.error(error.localizedDescription)
}
