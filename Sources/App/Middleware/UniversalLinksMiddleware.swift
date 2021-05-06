//
//  UniversalLinksMiddleware.swift
//  
//
//  Created by 蘇健豪 on 2021/5/6.
//

import Vapor

struct UniversalLinksMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        next.respond(to: request).map { response in
            response.headers.add(name: "content-type", value: "application/json")
            return response
        }
    }
    
}
