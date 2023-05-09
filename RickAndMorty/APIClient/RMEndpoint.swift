//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 26/04/2023.
//

import Foundation


/// Represents unique API endpoint
@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get chatacters info
    case character
    /// Endpoint to get locations info
    case location
    /// Endpoint to get episodes info
    case episode
}
