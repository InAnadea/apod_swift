//
//  MarsRoverPhotosRepositoryImpl.swift
//  NASA
//
//  Created by Ivan Nazarov on 22.09.2022.
//

import Foundation

private struct MarsRoverPhotosRepositoryKey: InjectionKey {
    static var currentValue: MarsRoverPhotosRepository = MarsRoverPhotosRepositoryImpl()
}

extension InjectedValues {
    var marsRoverPhotosRepository: MarsRoverPhotosRepository {
        get { Self[MarsRoverPhotosRepositoryKey.self] }
        set { Self[MarsRoverPhotosRepositoryKey.self] = newValue }
    }
}

class MarsRoverPhotosRepositoryImpl: MarsRoverPhotosRepository {
    func getPhotosPage(sol: Int? = nil, camera: String? = nil, page: Int? = nil) async throws -> RoverPhotos {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.nasa.gov"
        urlComponents.path = "/mars-photos/api/v1/rovers/curiosity/photos"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Configuration.NASA_API_Key),
        ]
        if sol != nil {
            urlComponents.queryItems?.append(URLQueryItem(name: "sol", value: String(sol!)))
        }
        if camera != nil {
            urlComponents.queryItems?.append(URLQueryItem(name: "camera", value: camera))
        }
        if page != nil {
            urlComponents.queryItems?.append(URLQueryItem(name: "page", value: String(page!)))
        }
        let url = URL(string: urlComponents.string!)!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw IncorrectFormatOfReponseError()
        }
        guard httpResponse.statusCode == 200 else {
            throw UnexpectedResponseCodeError(code: httpResponse.statusCode)
        }
        guard let photos = try? JSONDecoder().decode(RoverPhotos.self, from: data)  else {
            throw NetworkParseError<RoverPhotos>()
        }
        return photos
    }
}
