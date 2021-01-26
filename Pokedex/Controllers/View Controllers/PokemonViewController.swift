//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by River McCaine on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    // MARK: - Helper Function
    func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
   
            PokemonController.fetchSprite(for: pokemon) { (result) in
                DispatchQueue.main.async {
                switch result {
                case .success(let pokeSprite):
                    self.pokeImageView.image = pokeSprite
                    self.pokeNameLabel.text = pokemon.name.capitalized
                    self.pokeIDLabel.text = String(pokemon.id)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
} // END OF CLASS

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        // { (Result<Pokemon, PokemonError>)  }  ~> We just want to name it result in both cases of getting an error or Pokemon, so call it result.
        PokemonController.fetchPokemon(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(for: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
} // END OF EXTENSION










//    func fetchPokemon() {

//        PokemonController.fetchPokemon(searchTerm: "wobbuffet") { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case.success(let pokemon):
//                    PokemonController.fetchSprite(for: pokemon) { (<#Result<UIImage, PokemonError>#>) in
//                        <#code#>
//                    }
//                    self.pokeNameLabel.text = pokemon.name
//                    self.pokeIDLabel.text = String(pokemon.id)
//
//                case.failure(let error):
//                    self.presentErrorToUser(localizedError: error )
//                }
//            }
//        }
//    }
//



