//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 05/05/2023.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String { get }
    var episode: String { get }
    var airDate: String { get }
    
}

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataURL: URL?
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    
    // MARK: - Initialization
    init(episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
    
    
    // MARK: - Public
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
               dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataURL,
              let request = RMRequest(url: url) else {
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
            }
        }
    }

}
