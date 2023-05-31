//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 22/05/2023.
//

import UIKit


/// Configurable controller to search
final class RMSearchViewController: UIViewController {
    
    private let searchView: RMSearchView
    private let viewModel: RMSearchViewViewModel
    
    /// Configuration for search session
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
            
            var title: String {
                switch self {
                case .character:
                    return "Search Character"
                case .episode:
                    return "Search Episode"
                case .location:
                    return "Search Location"
                }
            }
        }
        
        let type: `Type`
    }
    
    // MARK: - Initialization
    init(config: Config) {
        self.viewModel = RMSearchViewViewModel(config: config)
        self.searchView = RMSearchView(frame: .zero, viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        searchView.pinToSaveArea(of: view)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapSearchButton))
    }
    
    
    // MARK: - Private
    @objc func didTapSearchButton() {
//        viewModel.executeSearch()
    }

}
