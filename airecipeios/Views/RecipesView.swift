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
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Search Recipes", text: $searchText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .layoutPriority(1)
                Button(action: {
                    let model = FirebaseAI.firebaseAI(backend: .googleAI()).generativeModel(modelName: "gemini-2.5-flash", generationConfig: GenerationConfig(
                        responseMIMEType: "application/json",
                        responseSchema: Schema.object(properties: [
                            "title": .string(),
                            "ingredients": Schema.array(items: Schema.object(properties: [
                                "name": .string(),
                                "quantity": .string(),
                                "unit": .string()
                            ])),
                            "instructions": .string()
                        ])
                    ))
                    let prompt = "Give me one cooking recipe."
                    
                    
                }) {
                    Text("Search")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .frame(maxHeight: .infinity, alignment: .top)
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
