//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Jakub Zajda on 05/05/2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let titleContainerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutUI() {
        contentView.addSubviews(titleContainerView, valueLabel)
        titleContainerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
            
        titleLabel.pinToEdges(of: titleContainerView)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.attributedText = nil
        titleLabel.textColor = .label
    }
    
    
    
    // MARK: - Public
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        valueLabel.text = viewModel.displayValue
                
        let imageAttachment = NSTextAttachment()
        let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
        imageAttachment.image = UIImage(systemName: viewModel.iconImage, withConfiguration: configuration)?.withTintColor(viewModel.tintColor)
        
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: " "+viewModel.title))
        
        titleLabel.attributedText = fullString
        titleLabel.textColor = viewModel.tintColor
    }
}

