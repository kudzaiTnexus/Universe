//
//  PostService.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol PostService {
    func fetchPosts(completion:@escaping (_ result: Result<[Post], ServiceError>) -> Void)
    //func fetchPostDetails(completion:@escaping (_ result: Result<Post, Swift.Error>) -> Void))
}

struct PostServiceImplementation: PostService, ServiceClient {
    
    private let servicePath: String = "https://jsonplaceholder.typicode.com/posts"
    private static let serviceLock = NSLock()
    
    func fetchPosts(completion result: @escaping (Result<[Post], ServiceError>) -> Void) {
        
        PostServiceImplementation.serviceLock.lock()
        
        defer {
            PostServiceImplementation.serviceLock.unlock()
        }
        
        let serviceUrl =  URL(string: servicePath)
        
        fetchResources(url: serviceUrl!, completion: result)
    }
    
}
