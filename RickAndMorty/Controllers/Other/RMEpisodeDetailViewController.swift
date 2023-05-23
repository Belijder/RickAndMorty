//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 09/05/2023.
//

import UIKit


/// VC to show details about single episode.
final class RMEpisodeDetailViewController: UIViewController, RMEpisodeDetailViewViewModelDelegate, RMEpisodeDetailViewDelegate {
    private let viewModel: RMEpisodeDetailViewViewModel
    private let detailview = RMEpisodeDetailView()
    
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
        title = "Episode Details"
        view.backgroundColor = .systemBackground
        view.addSubview(detailview)
        detailview.pinToSaveArea(of: view)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        detailview.delegate = self
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
    }
    
    
    @objc private func didTapShare() {
        
    }
    
    
    // MARK: - RMEpisodeDetailViewViewModelDelegate
    func didFetchEpisodeDetails() {
        detailview.configure(with: viewModel)
    }
    
    // MARK: - RMEpisodeDetailViewDelegate
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect Character: RMCharacter) {
        let destVC = RMCharacterDetailViewController(viewModel: .init(character: Character))
        destVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(destVC, animated: true)
    }
}
