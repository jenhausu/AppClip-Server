import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req -> String in
        "Hello, world!"
    }
    
    app.post("") { request -> Contact in
        try makeContact(with: request)
    }
    
    app.post("contact") { request -> Contact in
        try makeContact(with: request)
    }
    
    try app.register(collection: TodoController())
}
