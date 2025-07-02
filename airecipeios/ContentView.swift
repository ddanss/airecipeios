//
//  ContentView.swift
//  airecipeios
//
//  Created by Paul on 7/1/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            IngredientsView()
                .tabItem {
                    Label("Ingredients", systemImage: "leaf")
                }

            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
        }
    }
}

#Preview {
    ContentView()
}
