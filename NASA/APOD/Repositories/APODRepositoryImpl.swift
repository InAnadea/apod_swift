//
//  APODRepositoryImpl.swift
//  Nasa APOD
//
//  Created by Ivan Nazarov on 16.09.2022.
//

import Foundation

private struct APODRepositoryKey: InjectionKey {
    static var currentValue: APODRepository = APODRepositoryImpl()
}

extension InjectedValues {
    var networkProvider: APODRepository {
        get { Self[APODRepositoryKey.self] }
        set { Self[APODRepositoryKey.self] = newValue }
    }
}

struct APODRepositoryImpl: APODRepository {
    func getAPOD() async throws -> APOD? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.nasa.gov"
        urlComponents.path = "/planetary/apod"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Configuration.NASA_API_Key),
        ]
        let url = URL(string: urlComponents.string!)!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw IncorrectFormatOfReponseError()
        }
        guard httpResponse.statusCode == 200 else {
            throw UnexpectedResponseCodeError(code: httpResponse.statusCode)
        }
        guard let imageModel = try? JSONDecoder().decode(APOD.self, from: data) else {
            throw NetworkParseError<APOD>()
        }
        return imageModel
    }
}
