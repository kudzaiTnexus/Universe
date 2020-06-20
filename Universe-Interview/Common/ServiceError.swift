//
//  ServiceError.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case requestFailed
    case decodeError
    
    var message: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The provided URL is not valid",
                                     comment: "Invalid URL")
        case .requestFailed:
            return NSLocalizedString("The request has failed to complete. Please try again",
                                     comment: "Request failure")
        case .decodeError:
            return NSLocalizedString("Decoding error",
                                     comment: "Request failed")
        }
    }
}
