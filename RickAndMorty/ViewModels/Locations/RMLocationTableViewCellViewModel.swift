//
//  RMLocationTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 25/05/2023.
//

import Foundation

struct RMLocationTableViewCellViewModel: Equatable {
    private let location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    public var name: String {
        return location.name
    }
    
    public var type: String {
        return "Type: \(location.type)"
    }
    
    public var dimension: String {
        return location.dimension == "unknown" ? "Unknown dimension" : location.dimension
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }
}
