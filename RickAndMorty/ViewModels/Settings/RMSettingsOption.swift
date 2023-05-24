//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 24/05/2023.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var targetURL: URL? {
        switch self {
        case .rateApp, .contactUs:
            return nil
        case .terms:
            return URL(string: "https://doc-hosting.flycricket.io/rickandmorty-privacy-policy/4551b54c-56de-47c8-84c3-93a4bf9e8fef/privacy")
        case .privacy:
            return URL(string: "https://doc-hosting.flycricket.io/rickandmorty-privacy-policy/4551b54c-56de-47c8-84c3-93a4bf9e8fef/privacy")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation")
        case .viewSeries:
            return URL(string: "https://www.hbomax.com/pl/pl/series/urn:hbo:series:GXkRjxwjR68PDwwEAABKJ")
        case .viewCode:
            return URL(string: "https://github.com/Belijder/RickAndMorty")
        }
    }
    
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "Watch Rick and Morty"
        case .viewCode:
            return "View App Code"
        }
    }
    
    
    var iconContainerCollor: UIColor {
        switch self {
        case .rateApp:
            return .systemYellow
        case .contactUs:
            return .systemBlue
        case .terms:
            return .systemOrange
        case .privacy:
            return .systemRed
        case .apiReference:
            return .systemGreen
        case .viewSeries:
            return .systemMint
        case .viewCode:
            return .systemPink
        }
    }
    
    
    var iconImageName: String {
        switch self {
        case .rateApp:
            return "star.circle"
        case .contactUs:
            return "envelope.circle"
        case .terms:
            return "doc.circle"
        case .privacy:
            return "lock.circle"
        case .apiReference:
            return "list.bullet.circle"
        case .viewSeries:
            return "tv.circle"
        case .viewCode:
            return "hammer.circle"
        }
    }
}
