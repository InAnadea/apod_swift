//
//  APODViewModel.swift
//  Nasa APOD
//
//  Created by Ivan Nazarov on 16.09.2022.
//

import Foundation

extension APODView {
    @MainActor class ViewModel: ObservableObject {
        @Injected(\.apodRepository) private var apodRepo: APODRepository
        
        @Published private(set) var currentApod: APOD?
        
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
}
