//
//  Router.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire

typealias jsonDictionary = [String: AnyObject]

enum Router {
    
    // MARK: - Configuration
    private static let baseHostPath = "http://www.recipepuppy.com"
    private static let versionPath = "/api"
    var baseURLPath: String {
        return "\(Router.baseHostPath)\(Router.versionPath)"
    }
    
    // Recipes
    case getPuppyRecipe(name: String)
}

extension Router {
    
    struct Request {
        let method: Alamofire.HTTPMethod
        let path: String
        let encoding: ParameterEncoding?
        let parameters: jsonDictionary?
        
        init(method: Alamofire.HTTPMethod,
             path: String,
             parameters: jsonDictionary? = nil,
             encoding: ParameterEncoding = JSONEncoding.default) {
            
            self.method = method
            self.path = path
            self.encoding = encoding
            self.parameters = parameters
        }
    }
    
    var request: Request {
        switch self {

        case .getPuppyRecipe(let name):
            return Request(method: .get, path: "/?q=\(name)")
        }
    }
    
}

// MARK: - URLRequestConvertible
extension Router: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLPath)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(request.path))
        urlRequest.httpMethod = request.method.rawValue
        
        if let encoding = request.encoding {
            return try encoding.encode(urlRequest, with: request.parameters)
        } else {
            return urlRequest
        }
    }
}
