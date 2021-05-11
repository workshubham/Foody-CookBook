//
//  MealModel.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 10/05/21.
//

import Foundation

struct MealModel {
    
    let id: String
    let name: String
    let drinkAlternate: String
    let category: String
    let area: String
    let instructions: String
    let mealThumb: String
    let youtubeLink: String
    let source: String
    
    init?(data: [String: Any]) {
        
        id = data["idMeal"] as? String ?? ""
        name = data["strMeal"] as? String ?? ""
        drinkAlternate = data["strDrinkAlternate"] as? String ?? ""
        category = data["strCategory"] as? String ?? ""
        area = data["strArea"] as? String ?? ""
        instructions = data["strInstructions"] as? String ?? ""
        mealThumb = data["strMealThumb"] as? String ?? ""
        youtubeLink = data["strYoutube"] as? String ?? ""
        source = data["strSource"] as? String ?? ""
    }
}
