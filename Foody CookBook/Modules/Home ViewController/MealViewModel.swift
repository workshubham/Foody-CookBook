//
//  MealViewModel.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 10/05/21.
//

import Foundation

struct MealViewModel {
    
    let name: String
    let id: String
    let instructions: String
    let youtubeLink: String
    let area: String
    let category: String
    let mealThumb: String
    var isFavourite: Bool
    
    init(data: MealModel) {
        
        name = data.name
        id = data.id
        instructions = data.instructions
        youtubeLink = data.youtubeLink
        area = data.area
        category = data.category
        mealThumb = data.mealThumb
        isFavourite = false
    }
}
