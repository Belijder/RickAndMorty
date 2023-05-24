//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 24/05/2023.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    let id = UUID()
    
    // MARK: - Init
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHanler = onTapHandler
    }
    
    // MARK: - Public
    public var imageName: String{
        return type.iconImageName
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerCollor
    }
    
    public let onTapHanler: (RMSettingsOption) -> Void
    
    public let type: RMSettingsOption

}
