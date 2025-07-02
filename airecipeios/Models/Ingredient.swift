//
//  Ingredient.swift
//  airecipeios
//
//  Created by Paul on 7/1/25.
//

import SwiftData

@Model
class Ingredient {
    var name: String
    var checked: Bool
    
    init(name: String, checked: Bool = true) {
        self.name = name
        self.checked = checked
    }
}
