//
//  CommentService.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol CommentService {
    func fetchComments(for authorId: String, completion result: @escaping (Result<[Comment], ServiceError>) -> Void)
}

struct CommentServiceImplementation: CommentService, ServiceClient {
    
    private static let serviceLock = NSLock()
    
    func fetchComments(for authorId: String, completion result: @escaping (Result<[Comment], ServiceError>) -> Void) {
        
        let servicePath: String = "https://jsonplaceholder.typicode.com/posts/\(authorId)/comments"
        
        CommentServiceImplementation.serviceLock.lock()
        
        defer {
            CommentServiceImplementation.serviceLock.unlock()
        }
        
        let serviceUrl =  URL(string: servicePath)
        
        fetchResources(url: serviceUrl!, completion: result)
    }
    
}
