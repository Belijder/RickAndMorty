//
//  RMLocationsViewController.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 26/04/2023.
//

import UIKit

final class RMLocationsViewController: UIViewController {
    
    private let locationsView = RMLocationsListView()
    private let viewModel = RMLocationsListViewViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Locations"
        addSearchButton()
        view.addSubview(locationsView)
        locationsView.pinToSaveArea(of: view)
        viewModel.delegate = self
        viewModel.fetchInitialLocations()
    }
    
    
    // MARK: - Private
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
}

extension RMLocationsViewController: RMLocationsListViewViewModelDelegate {
    func didFetchInitialLocations() {
        locationsView.configure(with: viewModel)
    }
}
