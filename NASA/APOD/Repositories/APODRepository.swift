//
//  APODRepository.swift
//  Nasa APOD
//
//  Created by Ivan Nazarov on 16.09.2022.
//

import Foundation

protocol APODRepository {
    func getAPOD() async throws -> APOD
}
