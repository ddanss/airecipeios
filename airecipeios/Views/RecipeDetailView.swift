//
//  RecipeDetailView.swift
//  airecipeios
//
//  Created by Paul on 7/6/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipeToShow: Recipe?
    let onClose: () -> Void
    
    var body: some View {
        Color.white.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                ZStack {
                    VStack {
                        HStack {
                            Text("\(recipeToShow?.title ?? "NA")")
                                .font(.headline)
                            Spacer()
                            Button( action: {
                                onClose()
                            }, label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 30, height: 30, alignment: .center)
                                    Image(systemName: "xmark")
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                                .padding(8)
                                .contentShape(Circle())
                            })
                        }
                        ScrollView() {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("\(recipeToShow?.getIngredientsString() ?? "NA")")
                                Text("\(recipeToShow?.instructions ?? "NA")")
                            }
                        }
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(12)
                }
                .padding(20)
        )
    }
    
}
