//
//  RMService.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 26/04/2023.
//

import Foundation

/// API service object to get data from Rick and Morty database.
final class RMService {
    /// Shared singelton instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init() {}
    
    /// Send Rick and Morti API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
