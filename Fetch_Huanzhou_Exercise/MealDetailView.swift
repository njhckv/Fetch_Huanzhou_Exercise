//
//  MealDetailView.swift
//  Fetch_Huanzhou_Exercise
//
//  Created by Huanzhou Wang on 7/21/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @EnvironmentObject var viewModel: MealsViewModel
    @State private var mealDetail: MealDetail?
    
    var body: some View {
        ScrollView {
            if let mealDetail = mealDetail {
                Text(mealDetail.strMeal)
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.black)
                AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding()
                    
                } placeholder: {
                    ProgressView()
                }
                
                Text("Instruction").font(.title2)
                    .fontDesign(.rounded)
                    .fontWeight(.bold).padding(.horizontal)
                
                Text(mealDetail.strInstructions)
                    .padding()
                    .background(.gray.opacity(0.15))
                    .cornerRadius(20)
                    .padding()
                
                Text("Ingredients/measurements").font(.title2)
                    .fontDesign(.rounded)
                    .fontWeight(.bold).padding()
                ForEach(mealDetail.ingredients.indices, id: \.self) { index in
                    HStack(){
                        Text("\(mealDetail.ingredients[index])")
                        Spacer()
                        Text("\(mealDetail.measurements[index])").italic()
                    }.padding(.horizontal)
                }   .padding()
                    .background(.gray.opacity(0.15))
                    .cornerRadius(20)
                    .padding(.horizontal)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMealDetail(id: mealId)
                mealDetail = viewModel.mealDetail
            }
        }
    }
}
