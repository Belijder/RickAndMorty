//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 05/05/2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    private let modelType: InfoModelType
    private let value: String
    
    public var title: String {
        modelType.rawValue.capitalized
    }
    
    
    public var displayValue: String {
        if value.isEmpty { return "N/A" }
        
        if modelType == .created, let date = Utilities.dateFormatter.date(from: value) {
            return Utilities.shortDateFormatter.string(from: date)
        }
        
        return value
    }
    
    
    public var iconImage: String {
        switch modelType {
        case .status:
            return "waveform.path.ecg"
        case .gender:
            return "person.fill.questionmark"
        case .type:
            return "person.crop.circle.badge.questionmark"
        case .species:
            return "figure.stand"
        case .origin:
            return "globe.americas.fill"
        case .location:
            return "globe.asia.australia.fill"
        case .created:
            return "clock.fill"
        case .episodes:
            return "play.tv.fill"
        }
    }

    
    public var tintColor: UIColor {
        switch modelType {
        case .status:
            return .systemMint
        case .gender:
            return .systemBlue
        case .type:
            return .systemCyan
        case .species:
            return .systemPink
        case .origin:
            return .systemBrown
        case .location:
            return .systemIndigo
        case .created:
            return .systemOrange
        case .episodes:
            return .systemYellow
        }
    }
    
    
    enum InfoModelType: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodes
    }
    
    
    init(type: InfoModelType, value: String) {
        self.modelType = type
        self.value = value
    }

}
