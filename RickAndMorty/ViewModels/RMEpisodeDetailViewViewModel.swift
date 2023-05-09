//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 09/05/2023.
//

import UIKit

class RMEpisodeDetailViewViewModel {
    private let endpointURL: URL?
    
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endpointURL,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let episode):
                print(String(describing: episode))
            case .failure:
                break
            }
        }
    }
}
