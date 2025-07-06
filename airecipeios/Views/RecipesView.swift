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
    @Query(sort: \Recipe.createdDate, order: .reverse) var recipes: [Recipe]
    @Query var ingredients: [Ingredient]
    @State private var searchText: String = ""
    @State private var isLoading: Bool = false
    @State private var recipeToShow: Recipe? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    TextField("I'm feeling like cooking something...", text: $searchText)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .layoutPriority(1)
                    Button(action: {
                        isLoading = true
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
                            isLoading = false
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
                                .onTapGesture {
                                    recipeToShow = recipe
                                }
                        }
                        .onDelete(perform: { index in
                            let recipe = recipes[index.first!]
                            modelContext.delete(recipe)
                            try? modelContext.save()
                        })
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .onChange(of: recipes.count, { oldValue, newValue in
                if newValue > oldValue {
                    recipeToShow = recipes.first
                }
            })
            
            if isLoading {
                Color.gray.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        ProgressView {
                            Text("Searching for a recipe...")
                        }
                        .padding(12)
                        .background(Color.gray)
                        .cornerRadius(12)
                    )
            }
            
            if let recipe = recipeToShow {
                RecipeDetailView(recipeToShow: recipe) {
                    recipeToShow = nil
                }
            }
        }
    }
}
