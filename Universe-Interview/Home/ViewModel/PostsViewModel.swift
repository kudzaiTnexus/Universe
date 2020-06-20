//
//  PostsViewModel.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

class PostsViewModel {
    
    private var postsService: PostService = PostServiceImplementation()
    
    func fetchPosts(completion: @escaping (Result<[Post], ServiceError>) ->()) {
        
        postsService.fetchPosts { result in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
            case .success(let posts):
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
                
            }
        }
    }
    
    func fetchAuthorPosts(by authorId: Int, completion: @escaping (Result<[Post], ServiceError>) ->()) {
        self.fetchPosts { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
            case .success(let posts):
                DispatchQueue.main.async {
                    completion(.success(posts.filter({ post -> Bool in
                        post.userID == authorId
                    })))
                }
                
            }
            
        }
    }
    
}
