//
//  Recipe.swift
//  airecipeios
//
//  Created by Paul on 7/1/25.
//

import SwiftData

@Model
class Recipe {
    var title: String
    var ingredients: String
    var instructions: String
        
    init(title: String, ingredients: String, instructions: String) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
    }
}
