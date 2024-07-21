//
//  MealsViewModel.swift
//  Fetch_Huanzhou_Exercise
//
//  Created by Huanzhou Wang on 7/21/24.
//

import Foundation
import SwiftUI

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var mealDetail: MealDetail?

    func fetchMeals() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let mealsResponse = try decoder.decode([String: [Meal]].self, from: data)
            DispatchQueue.main.async {
                self.meals = mealsResponse["meals"] ?? []
            }
        } catch {
            print("Error fetching or decoding data: \(error.localizedDescription)")
        }
    }

    func fetchMealDetail(id: String) async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let mealResponse = try decoder.decode([String: [MealDetail]].self, from: data)
            DispatchQueue.main.async {
                self.mealDetail = mealResponse["meals"]?.first
            }
        } catch {
            print("Error fetching or decoding data: \(error.localizedDescription)")
        }
    }
}
