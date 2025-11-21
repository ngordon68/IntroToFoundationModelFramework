//
//  CartoonRecommendationModel.swift
//  FoundationModelSampleProject
//
//  Created by Nick Gordon on 10/28/25.
//
import Foundation
import FoundationModels


@Generable
struct CartoonRecommendationModel: Identifiable {
var id = UUID().uuidString
    
@Guide(description: "Provide title of cartoon")
var title:String
@Guide(description: "Provide year cartoon was published")
var yearPublished:Int
@Guide(description: "Provide rating with 1 being really terrible and 5 being really good")
var rating: Double
  @Guide(description: "Give me a random emoji that describes this cartoon")
var randomEMoji: String
}
