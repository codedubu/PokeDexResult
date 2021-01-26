//
//  Pokemon.swift
//  Pokedex
//
//  Created by River McCaine on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_shiny: URL
}






/*
 
 {
    "name": "squirtle",            > name key: string value  <
    "id: 7                         > id key: int value  <
    "sprites" {                    > sprites key: front_back values <
            "front_shiny: "url..." > front_shiny key: url value <
            }
    "nicknames" : [                > nickname key: [nicknames] value
            "Yung Squirt",         > nickname key: string value <
            "Squirtle Squad Don"
            ]
 }
 
 */

/*
 
 struct Pokemon {
    let moves: [SecondLevelMoveObject]
 }
 
 struct SecondLevelMoveObject {
    let move: Move
 }
 
 struct Move {
    let name: String
    let url: URL
 }
 
 */
