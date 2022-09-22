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
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=noMUwsMNFPp7gjdXZIzi7TBHSgxuF6ZHZMa7OYbh")!
        let (data,_) = try await URLSession.shared.data(from: url)
        if let imageModel = try? JSONDecoder().decode(APOD.self, from: data) {
            return imageModel
        } else {
            print("Invalid Response")
        }
        return nil
    }
}
