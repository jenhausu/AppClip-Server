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
        let value = try request.content.decode(ContactRequest.self)
        let id = value.id
        let contact = fetchContact(id: id)
        
        return contact
    }
    
    app.post("contact") { request -> Contact in
        let value = try request.content.decode(ContactRequest.self)
        let id = value.id
        let contact = fetchContact(id: id)
        
        return contact
    }
    
    try app.register(collection: TodoController())
}
