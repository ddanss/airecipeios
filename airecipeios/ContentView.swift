//
//  ContentView.swift
//  airecipeios
//
//  Created by Paul on 7/1/25.
//

import SwiftUI
import SwiftData

struct IngredientsView: View {
    @State private var showingAddSheet = false
    @State private var newIngredient = ""
    
    @Environment(\.modelContext) private var modelContext
    @Query var ingredients: [Ingredient]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.clear
            
            if ingredients.isEmpty {
                Text("Add your ingredients")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
            } else {
                List(ingredients) { ingredient in
                    HStack {
                        Text(ingredient.name)
                        Spacer()
                        Toggle("Checked", isOn: Binding(get: { ingredient.checked }, set: { newValue in ingredient.checked = newValue; try? modelContext.save() }))
                            .labelsHidden()
                            .toggleStyle(.automatic)
                    }
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.clear)
            }

            Button(action: { showingAddSheet = true }) {
                Label("Add Ingredient", systemImage: "plus")
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 6)
            }
            .padding(.bottom, 100)
            .padding(.trailing, 32)
            .accessibilityIdentifier("addIngredientButton")
            .sheet(isPresented: $showingAddSheet) {
                VStack(spacing: 20) {
                    Text("Add Ingredient")
                        .font(.headline)
                    TextField("Enter ingredient", text: $newIngredient)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .textContentType(.none)
                    HStack {
                        Button("Cancel") {
                            showingAddSheet = false
                            newIngredient = ""
                        }
                        Spacer()
                        Button("Add") {
                            let newItem = Ingredient(name: newIngredient)
                            modelContext.insert(newItem)
                            showingAddSheet = false
                            newIngredient = ""
                        }
                        .disabled(newIngredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding([.leading, .trailing], 30)
                }
                .presentationDetents([.medium])
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

struct RecipesView: View {
    var body: some View {
        Text("Recipes Screen")
            .font(.largeTitle)
            .padding()
    }
}

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
