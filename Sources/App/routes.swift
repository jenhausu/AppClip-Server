import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("getContact") { request -> Contact in
        let value = try request.content.decode(ContactRequest.self)
        let id = value.id
        let contact = fetchContact(id: id)
        
        return contact
    }

    try app.register(collection: TodoController())
}
