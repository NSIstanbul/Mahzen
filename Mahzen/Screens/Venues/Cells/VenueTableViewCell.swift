//
//  VenueTableViewCell.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    // MARK: Properties
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    fileprivate lazy var typeLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    fileprivate lazy var districtLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
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
        stackView.spacing = Defines.Metrics.Spacings.single
        return stackView
    }()
    
    // MARK: Lifecycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        contentView.addSubview(stackView)
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Defines.Metrics.Spacings.double),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Defines.Metrics.Spacings.double),
            photoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: Defines.Metrics.Spacings.single),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Defines.Metrics.Spacings.double),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Defines.Metrics.Spacings.double),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Defines.Metrics.Spacings.double)
        ])
    }
    
    // MARK: Public
    func configureCell(for venue: Venue) {
        nameLabel.text = venue.name
        districtLabel.text = venue.district
        typeLabel.text = venue.type
    }
    
    func configureCell(image: UIImage) {
        photoImageView.image = image
    }
}
