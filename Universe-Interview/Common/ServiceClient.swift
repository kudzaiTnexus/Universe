//
//  ServiceClient.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation


protocol ServiceClient {
    func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, ServiceError>) -> Void)
    func fetchResources<T:Decodable>(request: URLRequest, completion: @escaping (Result<T, ServiceError>) -> ())
}

extension ServiceClient {
    func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, ServiceError>) -> Void) {
           guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
               completion(.failure(.invalidURL))
               return
           }
           
           guard let url = urlComponents.url else {
               completion(.failure(.invalidURL))
               return
           }
           
           URLSession.shared.dataTask(with: url) { (result) in
               switch result {
               case .success(let (response, data)):
                   
                   guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                       200..<299 ~= statusCode else {
                           completion(.failure(.requestFailed))
                           return
                   }
                   
                   do {
                       let decoder = JSONDecoder()
                       decoder.keyDecodingStrategy = .convertFromSnakeCase
                       let value = try decoder.decode(T.self, from: data)
                       completion(.success(value))
                   } catch {
                       completion(.failure(.decodeError))
                   }
                   
               case .failure(_):
                   completion(.failure(.requestFailed))
               }
           }.resume()
           
       }
    
    /**
     Generic method to fetch resources of type T
     
     - parameter request: ful request
     - parameter completion: completion handler
     
     - returns: Result<>
     
     */
    
     func fetchResources<T:Decodable>(request: URLRequest, completion: @escaping (Result<T, ServiceError>) -> ()) {
        
        URLSession.shared.dataTask(with: request) { (result) in
            switch result {
            case .success(let (response,data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.requestFailed))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let values = try decoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure( _):
                completion(.failure(.requestFailed))
            }
        }.resume()
    }
}
