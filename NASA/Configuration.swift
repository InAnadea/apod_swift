//
//  Configuration.swift
//  NASA
//
//  Created by Ivan Nazarov on 22.09.2022.
//

import Foundation

struct Configuration {
    static private let infoBundle = Bundle.main.infoDictionary ?? [:]
    
    static public let NASA_API_Key: String = infoBundle["NASA API key"] as! String
    
    private init() {}
}
