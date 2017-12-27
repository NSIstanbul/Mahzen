//
//  VenueCollectionViewCell.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit

class VenueCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    fileprivate lazy var typeLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    fileprivate lazy var districtLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.backgroundColor = Defines.Colors.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Defines.Metrics.cornerRadius
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(districtLabel)
        stackView.axis = .vertical
        stackView.alignment = UIStackViewAlignment.top
        stackView.spacing = Defines.Metrics.Spacings.single
        return stackView
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    fileprivate func setupLayout() {
        contentView.addSubview(stackView)
        contentView.addSubview(photoImageView)
        
        let stackViewBottomConstraint = stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        stackViewBottomConstraint.priority = .defaultLow
        
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Defines.Metrics.Spacings.double),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Defines.Metrics.Spacings.double),
            photoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: Defines.Metrics.Spacings.single),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Defines.Metrics.Spacings.double),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Defines.Metrics.Spacings.double),
            stackViewBottomConstraint
        ])
    }
    
    // MARK: Public
    func configureCell(for venue: Venue) {
        nameLabel.text = venue.name
        typeLabel.text = venue.type
        districtLabel.text = venue.district
    }
    
    func configureCell(image: UIImage) {
        photoImageView.image = image
    }
}
