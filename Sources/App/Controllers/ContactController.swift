//
//  ContactController.swift
//  
//
//  Created by 蘇健豪 on 2021/5/3.
//

import Foundation
import Vapor

struct Contact: Content {
    let id: Int
    let name: String
    let phoneNumber: String
    let companyName: String
}

struct ContactRequest: Content {
    let id: Int
}

//struct ContactController: RouteCollection {
//
//    func boot(routes: RoutesBuilder) throws {
//        <#code#>
//    }
//
//}

func fetchContact(id: Int) -> Contact {
    if id == 1 {
        return Contact(id: id, name: "Nolan", phoneNumber: "0960777777", companyName: "光禾")
    } else if id == 2 {
        return Contact(id: id, name: "Claire", phoneNumber: "0912333444", companyName: "光禾")
    } else if id == 3 {
        return Contact(id: id, name: "Nicole", phoneNumber: "0956222333", companyName: "光禾")
    } else {
        return Contact(id: 0, name: "", phoneNumber: "", companyName: "")
    }
}

func makeContact(with request: Request) throws -> Contact {
    let value = try request.content.decode(ContactRequest.self)
    let id = value.id
    let contact = fetchContact(id: id)
    
    return contact
}
