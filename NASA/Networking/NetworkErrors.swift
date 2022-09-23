//
//  NetworkErrors.swift
//  NASA
//
//  Created by Ivan Nazarov on 22.09.2022.
//

import Foundation

protocol NetworkError: Error {
    var error: Any? { get }
    var message: String { get }
}

class NetworkParseError<T>: NetworkError {
    let error: Any?
    let message: String = "Can't parse data for type: \"\(T.self)\""
    
    init() {
        self.error = nil
    }
    
    init(error: Any?) {
        self.error = error
    }
}

class UnexpectedResponseCodeError: NetworkError {
    let error: Any?
    let code: Int
    var message: String {
        get { "Unexpected response code: \(self.code)" }
    }
    
    init(code: Int) {
        self.code = code
        self.error = nil
    }
    
    init(code: Int, error: Any?) {
        self.code = code
        self.error = error
    }
}


class IncorrectFormatOfReponseError: NetworkError {
    let error: Any?
    var message: String {
        get { "Incorrect format of response" }
    }
    
    init(error: Any?) {
        self.error = error
    }
    
    init() {
        self.error = nil
    }
}
