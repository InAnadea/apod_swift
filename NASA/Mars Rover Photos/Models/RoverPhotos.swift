//
//  Photos.swift
//  NASA
//
//  Created by Ivan Nazarov on 23.09.2022.
//

import Foundation

struct RoverPhotos: Codable {
    var photos: [Photo]
}

extension RoverPhotos {
    struct Photo: Codable, Identifiable {
        var id = UUID()
        var sol: Int
        var img_src: String
        var earth_date: String
        var rover: Rover
        var camera: Camera
        
        
        private enum CodingKeys: String, CodingKey {
            case sol, img_src, earth_date, rover, camera
        }
    }
    
    mutating func add(_ roverPhotos: RoverPhotos) {
        photos.append(contentsOf: roverPhotos.photos)
    }
}

extension RoverPhotos.Photo {
    struct Camera: Codable {
        var id: Int
        var name: String
        var rover_id: Int
        var full_name: String
    }
    
    struct Rover: Codable {
        var id: Int
        var name: String
        var landing_date: String
        var launch_date: String
        var status: String
    }
}
