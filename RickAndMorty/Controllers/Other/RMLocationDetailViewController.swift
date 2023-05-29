//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 26/05/2023.
//

import UIKit

class RMLocationDetailViewController: UIViewController {
    private let locationDetailView = RMLocationDetailView()
    private let viewModel: RMLocationDetailViewViewModel
    
    
    // MARK: - Initialization
    init(location: RMLocation) {
        self.viewModel = RMLocationDetailViewViewModel(location: location)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location details"
        view.backgroundColor = .systemBackground
        view.addSubview(locationDetailView)
        locationDetailView.pinToSaveArea(of: view)
        viewModel.delegate = self
        locationDetailView.delegate = self
        
    }
}

// MARK: - RMLocationDetailViewViewModelDelegate
extension RMLocationDetailViewController: RMLocationDetailViewViewModelDelegate {
    func didFetchReleatedCharacters() {
        locationDetailView.configure(with: viewModel)
    }
}

// MARK: -  RMLocationDetailViewDelegte
extension RMLocationDetailViewController: RMLocationDetailViewDelegte {
    func rmLocationDetailView(_ locationDetailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let destVC = RMCharacterDetailViewController(viewModel: .init(character: character))
        destVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(destVC, animated: true)
    }
}
