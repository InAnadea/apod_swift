//
//  MarsRoverPhotosRepository.swift
//  NASA
//
//  Created by Ivan Nazarov on 22.09.2022.
//

import Foundation

protocol MarsRoverPhotosRepository {
    func getPhotosPage(sol: Int?, camera: String?, page: Int?) async throws -> RoverPhotos
}
