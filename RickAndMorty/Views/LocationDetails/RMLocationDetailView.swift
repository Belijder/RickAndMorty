//
//  RMLocationDetailView.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 26/05/2023.
//

import UIKit

protocol RMLocationDetailViewDelegte: AnyObject {
    func rmLocationDetailView(_ locationDetailView: RMLocationDetailView, didSelect character: RMCharacter)
}

class RMLocationDetailView: UIView {
    
    public weak var delegate: RMLocationDetailViewDelegte?
    
    private var viewModel: RMLocationDetailViewViewModel? {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.reloadData()
            self.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }
    
    private var collectionView: UICollectionView?
    private var spinner = Utilities.createSpinner()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        spinner.startAnimating()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RMInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMInfoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        return collectionView
    }
    
    
    private func layoutUI() {
        guard let collectionView = collectionView else { return }
        collectionView.pinToEdges(of: self)
        
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    // MARK: - Public
    public func configure(with viewModel: RMLocationDetailViewViewModel) {
        self.viewModel = viewModel
    }
}


// MARK: - UICollectionViewDelegate
extension RMLocationDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        let sections = viewModel.cellViewModels
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .information:
            break
        case .characters:
            if let character = viewModel.character(at: indexPath.row) {
                delegate?.rmLocationDetailView(self, didSelect: character)
            }
        }
    }
    
}


// MARK: - UICollectionViewDataSource
extension RMLocationDetailView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModels else { return 0 }
        let sectionType = sections[section]
        switch sectionType {
        case .information(viewModels: let viewModels):
            return viewModels.count
        case .characters(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sections = viewModel?.cellViewModels else { fatalError() }
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .information(viewModels: let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMInfoCollectionViewCell.cellIdentifier, for: indexPath) as? RMInfoCollectionViewCell else { fatalError() }
            cell.configure(with: cellViewModel)
            return cell
        case .characters(viewModels: let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else { fatalError() }
            cell.configure(with: cellViewModel)
            return cell
        }
    }
}



// MARK: - UICollectionViewLayout
extension RMLocationDetailView {
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else {
            return createInfoLayout()
        }
        
        switch sections[section] {
        case .information:
            return createInfoLayout()
        case .characters:
            return createCharacterLayout()
        }
    }
    
    
    private func createInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .absolute(80)),
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    private func createCharacterLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .absolute(240)),
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
