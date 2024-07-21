//
//  ContentView.swift
//  Fetch_Huanzhou_Exercise
//
//  Created by Huanzhou Wang on 7/21/24.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = MealsViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.meals, id: \.idMeal) { recipe in
                NavigationLink(destination: MealDetailView(mealId: recipe.idMeal)
                    .environmentObject(viewModel)) {
                        HStack {
                            AsyncImage(url: URL(string: recipe.strMealThumb)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 100)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            } placeholder: {
                                ProgressView()
                            }
                            VStack {
                                Text(recipe.strMeal)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                            }
                            .padding()
                        }
                    }
            }
            .navigationTitle("Dessert Recipe")
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}
#Preview {
    ContentView()
}
