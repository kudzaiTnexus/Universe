//
//  CommentsViewModel.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation


class CommentsViewModel {
    
    private var commentsService: CommentService = CommentServiceImplementation()
    
    func fetchComments(for authourId: String, completion: @escaping (Result<[Comment], ServiceError>) ->()) {
        
        commentsService.fetchComments(for: authourId) { result in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
            case .success(let comments):
                DispatchQueue.main.async {
                    completion(.success(comments))
                }
                
            }
        }
    }
    
}
