//
//  MainNewsTableViewCell.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 11.11.22..
//

import UIKit

struct MainNewsCellModel {
    let imageUrlLink: String
    let newsTitle: String
    let newsDescription: String
}

class MainNewsTableViewCell: UITableViewCell {
    static let identifier = "mainNewsTableViewCell"
    private var cellModel: MainNewsCellModel!
    
    // UI elements
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var newsImage: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addAllSubviews()
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension MainNewsTableViewCell {
    
    private func addAllSubviews() {
        let screenWidth = UIScreen.main.bounds.size.width
        titleLabel = UILabel(frame: CGRect(x: 30, y: 10, width: screenWidth - 60, height: 70))
        contentView.addSubview(titleLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: 30, y: 90, width: screenWidth - 60, height: 90))
        contentView.addSubview(descriptionLabel)
        
        newsImage = UIImageView(frame: CGRect(x: screenWidth/2 - 60, y: 190, width: 120, height: 100))
        contentView.addSubview(newsImage)
//        newsImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    private func customizeUI() {
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .gray
        descriptionLabel.font = .systemFont(ofSize: 13)
    }
}

// MARK: - Set model
extension MainNewsTableViewCell {
    func setModel(_ model: Any) {
        guard let model = model as? MainNewsCellModel else {
            fatalError("MainNewsCellModel: attempt to create with wrong model type! Received type: \(type(of: model)).")
        }
        self.cellModel = model
        titleLabel.text = model.newsTitle
        descriptionLabel.text = model.newsDescription
        descriptionLabel.numberOfLines = 0
        NetworkManager.shared.downloadImage(from: model.imageUrlLink) { [weak self] data in
            self?.newsImage.image = UIImage(data: data)
        }
    }
}
