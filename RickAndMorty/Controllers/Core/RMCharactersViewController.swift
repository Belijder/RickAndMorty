//
//  RMCharactersViewController.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 26/04/2023.
//

import UIKit

final class RMCharactersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RMRequest(endpoint: .character,
                                pathComponents: ["1"],
                                queryParameters: [
                                    URLQueryItem(name: "name", value: "rick"),
                                    URLQueryItem(name: "status", value: "alive")
                                ])
        
        print(request.url)
        
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
            switch result {
            case .success(let character):
                <#code#>
            case .failure(let failure):
                <#code#>
            }
        }

    }
    


}
