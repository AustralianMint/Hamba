import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import Foundation

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    let jsonData = readLocalJSONFile(forName: "postgresql")
    print("the data received is: ", jsonData)

    if let data = jsonData {
        if let postgresRecordObj = parse(jsonData: data) {
            app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
                hostname: postgresRecordObj.host ?? "localhost",
                port: postgresRecordObj.port ?? SQLPostgresConfiguration.ianaPortNumber,
                username: postgresRecordObj.user ?? "vapor_username",
                password: postgresRecordObj.password ?? "vapor_password",
                database: postgresRecordObj.database ?? "vapor_database",
                tls: .prefer(try .init(configuration: .clientDefault)))
            ), as: .psql)
        }
    }


    //app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
    //    hostname: Environment.get("DATABASE_HOST") ?? "localhost",
    //    port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
    //    username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
    //    password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
    //    database: Environment.get("DATABASE_NAME") ?? "vapor_database",
    //    tls: .prefer(try .init(configuration: .clientDefault)))
    //), as: .psql)

    app.migrations.add(CreateTodo())
    // register routes
    try routes(app)
}

// Reading the json file to get the login for postgres.
func readLocalJSONFile(forName name: String) -> Data? {
    do {

        if let filePath = Bundle.module.path(forResource: name, ofType: "json") {
            print("got to the first functions if let statement. should return data.")
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

struct loginCred: Codable {
    let host: String
    let user: String
    let password: String
    let database: String
    let port: Int
}

func parse(jsonData: Data) -> loginCred? {
    do {
        let decodedData = try JSONDecoder().decode(loginCred.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

