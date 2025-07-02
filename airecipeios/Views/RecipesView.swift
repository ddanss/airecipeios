//
//  RecipesView.swift
//  airecipeios
//
//  Created by Paul on 7/1/25.
//

import SwiftUI
import SwiftData

struct RecipesView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var recipes: [Recipe]
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("Search Recipes", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
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
