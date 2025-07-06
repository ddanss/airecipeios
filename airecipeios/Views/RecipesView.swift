//
//  RecipesView.swift
//  airecipeios
//
//  Created by Paul on 7/1/25.
//

import SwiftUI
import SwiftData
import FirebaseAI

struct RecipesView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var recipes: [Recipe]
    @Query var ingredients: [Ingredient]
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("I'm feeling like cooking something...", text: $searchText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .layoutPriority(1)
                Button(action: {
                    var prompt = "Give me one cooking recipe."
                    if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        prompt += " I want something \(searchText)."
                    }
                    let checkedIngredients = ingredients.filter { !$0.checked }
                    if !checkedIngredients.isEmpty {
                        prompt += " The only ingredients I have are \(ingredients.map((\.name)).joined(separator: ", "))."
                    }
                    
                    Task {
                        await FetchRecipe.fetchRecipe(prompt: prompt, modelContext: modelContext)
                    }
                }) {
                    Text("Search")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .frame(minWidth: 100)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .frame(maxHeight: 100, alignment: .top)
            .layoutPriority(1)
            if recipes.isEmpty {
                
            } else {
                List {
                    ForEach(recipes) { recipe in
                        Text(recipe.title)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}
