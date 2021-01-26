//
//  PokemonController.swift
//  Pokedex
//
//  Created by River McCaine on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

// Shared Instance: helps us keep track of a single source of truth, so in this case we won't be needing one.
// Source of Truth: would normally be to keep track of one way or blueprint to change data, but in this case because we are only fetching data we wont be needing it. (It wont be modified at all.)

class PokemonController {
    // Endpoint
    // https://pokeapi.co/api/v2/pokemon/{7} or {squirtle}/
    static let baseURL = URL(string: "https://pokeapi.co/api/v2")
    static let pokemonEndpoint = "pokemon"
    
    // searchTerm: {"Gyarados"} OR {130}
    // (Result<completion 1, completion 2>)
    // (Result<successCase, failureCase>)
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon,PokemonError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        // https://pokeapi.co/api/v2/
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndpoint)
        // https://pokeapi.co/api/v2/pokemon/
        
        let finalURL = pokemonURL.appendingPathComponent(searchTerm)
        // https://pokeapi.co/api/v2/pokemon/{searchTerm}
        
        print(finalURL)
        //                                             ?    ?    ?  (error, nil)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let pokemonDecoder = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonDecoder))
            } catch let decodeError {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(decodeError)")
                print("Description: \(decodeError.localizedDescription)")
                print("========= ERROR =========")
                
                // Hey completion handler, upon failure, lets print out the decodeError for the thrownError.
                return completion(.failure(.thrownError(decodeError)))
            }
            
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping(Result<UIImage, PokemonError>) -> Void) {
        
        let url = pokemon.sprites.front_shiny
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            guard let sprite = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            completion(.success(sprite))
        }.resume()
    }
    
    
} // END OF CLASS
