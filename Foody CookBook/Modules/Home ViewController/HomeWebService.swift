//
//  HomeWebService.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 10/05/21.
//

import Foundation

class HomeWebService {
    
    static let shared = HomeWebService()
    private init() {}
    
    /// Fetching random meal
    /// - Parameters:
    ///   - url: get random meal
    ///   - onCompletion: Meal Model
    internal func getRandomMeal(url: URL, onCompletion: @escaping (MealModel?, String?, Error?) -> Void) {
    
        AlamoRequestManager.shared.requestDataFor(url, methodType: .get, params: nil) { response in
            
            DispatchQueue.global(qos: .background).async {
                if let response = response {
                    if let meals = response["meals"] as? [[String: Any]] {
                        guard let mealData = MealModel(data: meals[0]) else { return }
                        DispatchQueue.main.async {
                            onCompletion(mealData, nil, nil)
                        }
                    }
                }
            }
            
        } onError: { error, errorResponse in
            
            if error == nil {
                onCompletion(nil, nil, error)
            } else {
                onCompletion(nil, nil, nil)
            }
        }
    }
}
