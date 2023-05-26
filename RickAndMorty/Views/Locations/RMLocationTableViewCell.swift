//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 25/05/2023.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {
    static let cellIdentifier = "RMLocationTableViewCell"
    
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(nameLabel, typeLabel, dimensionLabel)
        layoutUI()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        typeLabel.text = nil
        nameLabel.text = nil
        dimensionLabel.text = nil
    }
    
    
    private func layoutUI() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            typeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            
            nameLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
          
            dimensionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            dimensionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            dimensionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            dimensionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - Public
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        self.typeLabel.text = viewModel.type
        self.nameLabel.text = viewModel.name
        self.dimensionLabel.text = viewModel.dimension
    }
}
