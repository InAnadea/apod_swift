//
//  APODViewModel.swift
//  Nasa APOD
//
//  Created by Ivan Nazarov on 16.09.2022.
//

import Foundation

class APODViewModel: ObservableObject {
    @Injected(\.networkProvider) private var apodRepo: APODRepository
    
    @Published var currentApod: APOD?
    
    @MainActor
    func getApod() {
        Task {
            do {
                currentApod = try await apodRepo.getAPOD()
            } catch {
                print(error)
            }
        }
    }
    
}
