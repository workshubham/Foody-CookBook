//
//  RequestGenerator.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 10/05/21.
//

import Foundation
import Alamofire

enum EndPoint {
    case getRandomMeal
    case searchMeal(String)
    case getMealDetail(String)
}

// MARK: EndPoint Extension
// Creating & Appending Endpoints to the URL
extension EndPoint {
    
    var endPoint: String {
        
        switch self {
        case .getRandomMeal:
            return "/random.php"
        case .searchMeal(let searchText):
            return "/search.php?s=\(searchText)"
        case .getMealDetail(let id):
            return "/lookup.php?i=\(id)"
        }
    }
}

// MARK: Reguest Generator Protocol
// Header Param
protocol RequestGeneratorProtocol {
    
    var headerParams: HTTPHeaders {get}
}

extension RequestGeneratorProtocol {
    
    var headerParams: HTTPHeaders {
        
        get {
            
            var headerDictionary: HTTPHeaders = HTTPHeaders()
            headerDictionary = ["Content-Type": "application/json"]
            return headerDictionary
        }
    }
    
    // Get Complete Url
    func completeUrl(endpoint: EndPoint) -> String {
        
        let urlString = baseUrl + endpoint.endPoint
        return urlString
    }
}
