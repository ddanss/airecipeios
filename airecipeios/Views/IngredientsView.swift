//
//  IngredientsView.swift
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
            if ingredients.isEmpty {
                Text("Add your ingredients")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
            } else {
                List {
                    ForEach(ingredients) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Toggle("Checked", isOn: Binding(get: { ingredient.checked }, set: { newValue in ingredient.checked = newValue; try? modelContext.save() }))
                                .labelsHidden()
                                .toggleStyle(.automatic)
                        }
                    }
                    .onDelete(perform: deleteIngredients)
                }
                .listStyle(.plain)
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
            .padding(.bottom, 10)
            .padding(.trailing, 32)
            .accessibilityIdentifier("addIngredientButton")
            .sheet(isPresented: $showingAddSheet) {
                VStack(spacing: 20) {
                    Text("Add Ingredient")
                        .font(.headline)
                    TextField("Enter ingredient", text: $newIngredient)
                        .textFieldStyle(.roundedBorder)
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
    
    private func deleteIngredients(at offsets: IndexSet) {
        for index in offsets {
            let ingredient = ingredients[index]
            modelContext.delete(ingredient)
        }
    }
}

#Preview {
    IngredientsView()
}
