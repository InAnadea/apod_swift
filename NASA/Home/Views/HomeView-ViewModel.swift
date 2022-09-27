//
//  HomeView-ViewModel.swift
//  NASA
//
//  Created by Ivan Nazarov on 26.09.2022.
//

import Foundation

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Injected(\.apodRepository) private var apodRepo: APODRepository
        @Injected(\.marsRoverPhotosRepository) private var marsRoverPhotosRepo: MarsRoverPhotosRepository
        
        @Published private(set) var currentApod: APOD? = nil
        @Published private(set) var roverPhotos: RoverPhotos? = nil
        
        func getApod() {
            Task {
                do {
                    let res = try await apodRepo.getAPOD()
                    currentApod = res
                } catch {
                    print(error)
                }
            }
        }
        
        func getRoverPhotos() {
            Task {
                do {
                    roverPhotos = try await marsRoverPhotosRepo.getPhotosPage(sol: 1000, camera: nil, page: 1)
                } catch {
                    print(error)
                }
            }
        }
        
    }
}
