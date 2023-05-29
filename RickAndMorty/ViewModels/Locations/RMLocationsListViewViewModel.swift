//
//  RMLocationsListViewViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 25/05/2023.
//

import Foundation

protocol RMLocationsListViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

final class RMLocationsListViewViewModel {
    
    init() { }
    weak var delegate: RMLocationsListViewViewModelDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    private var hasMoreSesults: Bool {
        return false
    }
    
    private var responseInfo: RMGetAllLocationsResponse.Info? = nil
    
    
    // MARK: - Public
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    
    public func location(at index: Int) -> RMLocation? {
        guard index < locations.count, index >= 0 else {
            return nil
        }
        
        return self.locations[index]
    }
    
    
    public func fetchInitialLocations() {
        RMService.shared.execute(.listOfLocationsRequest, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.locations = response.results
                self?.responseInfo = response.info
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure:
                break
            }
        }
    }
    
    
}
