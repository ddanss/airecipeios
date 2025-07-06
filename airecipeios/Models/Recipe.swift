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
    var ingredients: [[String:String]]
    var instructions: String
        
    init(title: String, ingredients: [[String:String]], instructions: String) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    func getIngredientsString() -> String {
        return ingredients.map { "\($0["name"] ?? "") (\($0["quantity"] ?? "") \($0["unit"] ?? ""))" } .joined(separator: "\n")
    }
}
