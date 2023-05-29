//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 09/05/2023.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel {
    private let endpointURL: URL?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharacterCollectionViewCellViewModel])
    }
    
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: - Initialization
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
    }
    
    // MARK: - Public
    /// Fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endpointURL,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let episode):
                self?.fetchReleatedCharacters(episode: episode)
            case .failure:
                break
            }
        }
    }
    
    
    public func character(at index: Int) -> RMCharacter? {
        return dataTuple?.characters[index]
    }
    
    // MARK: - Private
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else { return }
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
        var createdString = episode.created
        if let createdDate = Utilities.dateFormatter.date(from: episode.created) {
            createdString = Utilities.shortDateFormatter.string(from: createdDate)
        }
        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode", value: episode.episode),
                .init(title: "Title", value: episode.name),
                .init(title: "Air Date", value: episode.airDate),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModels: characters.compactMap({ RMCharacterCollectionViewCellViewModel(characterName: $0.name,
                                                                                                   characterStatus: $0.status,
                                                                                                   characterImageURL: URL(string: $0.image))
            }))
        ]
    }
    
    
    private func fetchReleatedCharacters(episode: RMEpisode) {
        let charatersURLs = episode.characters.compactMap { URL(string: $0) }
        let requests = charatersURLs.compactMap { RMRequest(url: $0) }
        
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
            self.dataTuple = (episode: episode, characters: characters)
        }
        
    }
}
