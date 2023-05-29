//
//  RMLocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 26/05/2023.
//

import Foundation

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchReleatedCharacters()
}

final class RMLocationDetailViewViewModel {
    
    private let location: RMLocation
    private var characters: [RMCharacter]? {
        didSet {
            createCellViewModels()
            delegate?.didFetchReleatedCharacters()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMInfoCollectionViewCellViewModel])
        case characters(viewModels: [ RMCharacterCollectionViewCellViewModel])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    public weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    // MARK: - Initialization
    init(location: RMLocation) {
        self.location = location
        fetchReleatedCharacters()
    }
    
    // MARK: - Public
    public func character(at index: Int) -> RMCharacter? {
        return characters?[index]
    }
    
    
    // MARK: - Private
    private func createCellViewModels() {
        guard let characters = characters else { return }
        
        var createdString = location.created
        if let createdDate = Utilities.dateFormatter.date(from: createdString) {
            createdString = Utilities.shortDateFormatter.string(from: createdDate)
        }
        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(characterName: character.name,
                                                              characterStatus: character.status,
                                                              characterImageURL: URL(string: character.image))
            }))
        ]
    }
    
    
    private func fetchReleatedCharacters() {
        let characterURLs = location.residents.compactMap { URL(string: $0) }
        let requests = characterURLs.compactMap { RMRequest(url: $0) }
        let group = DispatchGroup()
        
        var characters: [RMCharacter] = []
        
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let character):
                    characters.append(character)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.characters = characters
        }
    }
}
