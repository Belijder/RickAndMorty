//
//  RMEpisodesViewController.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 26/04/2023.
//

import UIKit

final class RMEpisodesViewController: UIViewController, RMEpisodeListViewDelegate {

    private let episodeListView = RMEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episodes"
        addSearchButton()
        setUpView()
    }
    
    private func setUpView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        episodeListView.pinToSaveArea(of: view)
    }
    
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let destVC = RMSearchViewController(config: .init(type: .episode))
        destVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    // MARK: - RMEpisodeListViewDelegate
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
