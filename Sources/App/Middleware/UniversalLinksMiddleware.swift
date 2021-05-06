//
//  UniversalLinksMiddleware.swift
//  
//
//  Created by 蘇健豪 on 2021/5/6.
//

import Vapor

struct UniversalLinksMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        guard request.url.string == "/.well-known/apple-app-site-association" else {
            return next.respond(to: request)
        }
        
        return next.respond(to: request).map { response in
            response.headers.add(name: "content-type", value: "application/json")
            return response
        }
    }
    
}
