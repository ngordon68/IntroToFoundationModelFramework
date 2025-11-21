//
//  ContentView.swift
//  FoundationModelSampleProject
//
//  Created by Nick Gordon on 10/21/25.
//

import SwiftUI
import FoundationModels


struct ContentView: View {
    @State var cartoonRecommendations: [CartoonRecommendationModel] = [
        
    ]
    @State private var currentGenre: CartoonCategory = .action

    let currentTopic: String = "Cartoons"
    let modelSession = LanguageModelSession()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Genre")
                    Picker("Select Genre", selection: $currentGenre) {
                        ForEach(CartoonCategory.allCases, id: \.self) { recommendation in
                            Text(recommendation.rawValue)
                        }
                    }
                }
                
                Button {
                    Task {
                        try await generateTopCartoons(currentGenrate: currentGenre)
                    }
                } label: {
                    Text("Generate Top 10")
                }
                .tint(.purple)
                .buttonStyle(.glass)
                .shadow(radius: 5)
                
                if cartoonRecommendations.isEmpty {
                    unavaliableView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(cartoonRecommendations) { cartoon in
                            HStack(spacing: 12) {
                                Image(systemName: "tv.fill")
                                    .foregroundStyle(.tint)
                                Text(cartoon.title)
                                    .font(.headline)
                                
                                Text(cartoon.randomEMoji)
                                    //.font(.largeTitle)
                                Spacer()
                                Text("Rating: \(String(format: "%.2f", cartoon.rating))")

                                    
                                    
                               
                                    
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("\(currentTopic) Top 10")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Clear All") {
                        clearAllRecommendations()
                    }
                }
            }
            
        }
    }
    
    var unavaliableView: some View {
        ContentUnavailableView(
            "No \(currentTopic) Yet",
            systemImage: "sparkles.tv",
            description: Text("Tap Generate to add some favorites.")
        )
    }
    
    func clearAllRecommendations() {
        cartoonRecommendations.removeAll()
    }
    
    func generateTopCartoons(currentGenrate: CartoonCategory) async throws  {
        
        let results =  try await modelSession.respond(to: "Please suggest me 10 cartoons from the year 2000 to 2010 that is not already listed in \(cartoonRecommendations)",
        
    generating: CartoonRecommendationModel.self
        )
   
        cartoonRecommendations.append(results.content)
        
    }
    
    func generate10Cartoons(currentGenrate: CartoonCategory) async throws {
        for cartoon in 0..<10 {
            try await generateTopCartoons(currentGenrate: currentGenrate)
        }
    }
}

#Preview {
    ContentView()
}
