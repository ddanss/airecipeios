//
//  FetchRecipe.swift
//  airecipeios
//
//  Created by Paul on 7/5/25.
//

import Foundation
import SwiftData
import FirebaseAI

class FetchRecipe {
    @MainActor
    static func fetchRecipe(prompt: String, modelContext: ModelContext) async {
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
        do {
            let response = try await model.generateContent(prompt)
            let jsonData = Data(response.text!.utf8)
            let recipeDictionary = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
            let recipe: Recipe = Recipe(
                title: recipeDictionary["title"] as? String ?? "Title",
                ingredients: recipeDictionary["ingredients"] as? [[String: String]] ?? [],
                instructions: recipeDictionary["instructions"] as? String ?? "NA"
            )
            modelContext.insert(recipe)
        } catch {
            print("ERROR")
        }
    }
}
