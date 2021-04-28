import Fluent
import FluentPostgresDriver
import Leaf
import Vapor
import NIOSSL

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)

    app.migrations.add(CreateTodo())

    app.views.use(.leaf)
    
    setHTTP2Config(app)

    // register routes
    try routes(app)
}

private func setHTTP2Config(_ app: Application) {
    let homePath = app.directory.workingDirectory
    let certPath = homePath + "cert.pem"
    let keyPath = homePath + "key.pem"
    
    do {
        let certs = try NIOSSLCertificate.fromPEMFile(certPath).map { NIOSSLCertificateSource.certificate($0) }
        let tls = TLSConfiguration.forServer(certificateChain: certs, privateKey: .file(keyPath))
        app.http.server.configuration = .init(hostname: "127.0.0.1",
                                              port: 8080,
                                              backlog: 256,
                                              reuseAddress: true,
                                              tcpNoDelay: true,
                                              responseCompression: .disabled,
                                              requestDecompression: .disabled,
                                              supportPipelining: false,
                                              supportVersions: Set<HTTPVersionMajor>([.two]),
                                              tlsConfiguration: tls,
                                              serverName: nil,
                                              logger: nil)
    } catch {
        print(error)
    }
}
