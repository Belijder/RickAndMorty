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
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    public var title: String {
        modelType.rawValue.capitalized
    }
    
    public var displayValue: String {
        if value.isEmpty { return "N/A" }
        
        if modelType == .created, let date = Self.dateFormatter.date(from: value) {
            return Self.shortDateFormatter.string(from: date)
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
    
//    public var iconImage: UIImage? {
//        switch modelType {
//        case .status:
//            return UIImage(systemName: "waveform.path.ecg")
//        case .gender:
//            return UIImage(systemName: "person.fill.questionmark")
//        case .type:
//            return UIImage(systemName: "person.crop.circle.badge.questionmark")
//        case .species:
//            return UIImage(systemName: "figure.stand")
//        case .origin:
//            return UIImage(systemName: "globe.americas.fill")
//        case .location:
//            return UIImage(systemName: "globe.asia.australia.fill")
//        case .created:
//            return UIImage(systemName: "clock.fill")
//        case .episodes:
//            return UIImage(systemName: "play.tv.fill")
//        }
//    }
    
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
