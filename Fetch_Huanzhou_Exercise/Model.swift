//
//  Model.swift
//  Fetch_Huanzhou_Exercise
//
//  Created by Huanzhou Wang on 7/21/24.
//

import Foundation

struct Meal: Identifiable, Hashable, Codable {
    var id: String { idMeal }
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct MealDetail: Identifiable, Codable {
    var id: String { idMeal }
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let ingredients: [String]
    let measurements: [String]

    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
             strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
             strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
             strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
             strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
             strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
             strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        ingredients = (1...20).compactMap {
            try? container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strIngredient\($0)")!)
        }.filter { !$0.isEmpty }
        
        measurements = (1...20).compactMap {
            try? container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strMeasure\($0)")!)
        }.filter { !$0.isEmpty }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strInstructions, forKey: .strInstructions)
        try container.encode(strMealThumb, forKey: .strMealThumb)
        
        for (index, ingredient) in ingredients.enumerated() {
            let key = CodingKeys(rawValue: "strIngredient\(index + 1)")!
            try container.encode(ingredient, forKey: key)
        }
        
        for (index, measurement) in measurements.enumerated() {
            let key = CodingKeys(rawValue: "strMeasure\(index + 1)")!
            try container.encode(measurement, forKey: key)
        }
    }
}
