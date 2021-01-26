//
//  PokemonError.swift
//  Pokedex
//
//  Created by River McCaine on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

enum PokemonError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Error 404: Unable to reach server."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "No data received from the server response."
        case .unableToDecode:
            return "Unable to turn the server's data into image."
        }
    }
}
