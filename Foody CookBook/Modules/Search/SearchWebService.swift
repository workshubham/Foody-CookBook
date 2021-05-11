//
//  SearchWebService.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 11/05/21.
//

import Foundation

class SearchWebService {
    
    static let shared = SearchWebService()
    private init() {}
    
    internal func searchMeal(url: URL, onCompletion: @escaping ([MealModel]?, String?, Error?) -> Void) {
        
        AlamoRequestManager.shared.requestDataFor(url, methodType: .get, params: nil) { response in
            
            var mealsData: [MealModel] = []
            DispatchQueue.global(qos: .background).async {
                if let response = response {
                    if let meals = response["meals"] as? [[String: Any]] {
                        for meal in meals {
                            guard let mealData = MealModel(data: meal) else { return }
                            mealsData.append(mealData)
                        }
                        DispatchQueue.main.async {
                            onCompletion(mealsData, nil, nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            onCompletion(mealsData, nil, nil)
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
