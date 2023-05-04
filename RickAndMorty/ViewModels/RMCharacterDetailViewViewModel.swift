//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 01/05/2023.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }

}
