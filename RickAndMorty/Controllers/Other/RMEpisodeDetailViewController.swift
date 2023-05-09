//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 09/05/2023.
//

import UIKit


/// VC to show details about single episode.
final class RMEpisodeDetailViewController: UIViewController {

    private let viewModel: RMEpisodeDetailViewViewModel
    
    // MARK: - Initialization
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endpointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBackground
    }
}
