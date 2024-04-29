import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import Foundation

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    //SSL notes.
    // note that the "hostname" in the file was changed to "localhost" instead of
    // "127.0.0.1", because the SSL connection expects under CN (Common Name) the 
    // name "localhost", and apparently to it the 127.0.0.1 and localhost are not
    // equal. Just a good thing to keep in mind. 
    // Also note that the files: "ca-cert.pem" && "server.csr" && "ca-key.pem" are under "/var/lib/postgresql/"
    // Furthermore, the files: "server-cert.pem" && "server-key.pem" are under "/var/lib/postgresql/data/"  
    let jsonData = readLocalJSONFile(forName: "postgresqllogin")
    print("the data received is: ", jsonData)

    //configures the tls connection for the vapor app.
    let caCertPath = "/var/lib/postgresql/ca-cert.pem"
    var tlsConfig = TLSConfiguration.makeClientConfiguration()
    tlsConfig.certificateVerification = .fullVerification

    let caCertificates = try NIOSSLCertificate.fromPEMFile(caCertPath)
    tlsConfig.trustRoots = .certificates(caCertificates)

    // convert to NIOSSLContext object from TLSConfiguration ojbect
    let sslContext = try NIOSSLContext(configuration: tlsConfig)

    if let data = jsonData {
        if let postgresRecordObj = parse(jsonData: data) {
            app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
                hostname: postgresRecordObj.host ?? "localhost",
                port: postgresRecordObj.port ?? SQLPostgresConfiguration.ianaPortNumber,
                username: postgresRecordObj.user ?? "vapor_username",
                password: postgresRecordObj.password ?? "vapor_password",
                database: postgresRecordObj.database ?? "vapor_database",
                tls: .require( sslContext))
                //tls: .prefer(try .init(configuration: .tlsConfig)))
            ), as: .psql)
        }
    }

    //this is where we define where the app gets hosted and on what port.
    app.http.server.configuration.hostname = "0.0.0.0"  // Listen on all interfaces
    app.http.server.configuration.port = 8081

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

