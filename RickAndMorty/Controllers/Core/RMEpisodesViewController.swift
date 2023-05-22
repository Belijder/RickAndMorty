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
        
        setUpView()
    }
    
    private func setUpView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        episodeListView.pinToSaveArea(of: view)
    }
    
    // MARK: - RMEpisodeListViewDelegate
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
