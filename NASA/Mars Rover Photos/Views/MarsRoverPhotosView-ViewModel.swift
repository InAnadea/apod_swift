//
//  MarsRoverPhotosView-ViewModel.swift
//  NASA
//
//  Created by Ivan Nazarov on 22.09.2022.
//

import Foundation

extension MarsRoverPhotosView {
    @MainActor class ViewModel: ObservableObject {
        @Injected(\.marsRoverPhotosRepository) var marsRoverPhotosRepository:  MarsRoverPhotosRepository
        
        @Published var roverPhotos: RoverPhotos = RoverPhotos(photos: [])
        @Published var isLastPage: Bool = false
        @Published var currentPage: Int = 0
        
        func getNextPage() {
            Task {
                do {
                    let result =  try await marsRoverPhotosRepository.getPhotosPage(sol: 1000, camera: nil, page: currentPage + 1)
                    roverPhotos.add(result)
                    
                    currentPage += 1
                    if result.photos.capacity < 25 {
                        isLastPage = true
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
