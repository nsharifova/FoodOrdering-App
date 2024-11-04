//
//  HomeTableViewCell.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 31.10.24.
//

import UIKit
import Kingfisher

class CardTableViewCell: UITableViewCell {
    var deleteProduct : (()->Void)?

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
  
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(deleteProductCart), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteProductCart() {
        deleteProduct?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8),
            
            countLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            countLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            countLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8),
            
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(data: CartProduct) {
        nameLabel.text = data.yemek_adi ?? ""
        priceLabel.text = "Price: \(data.yemek_fiyat ?? "")"
        countLabel.text = "Count: \(data.yemek_siparis_adet ?? "")"
        
        if let yemekResimAdi = data.yemek_resim_adi {
            let urlString = "\(Constants.apiUrl)/resimler/\(yemekResimAdi)"
            if let url = URL(string: urlString) {
                productImageView.kf.setImage(with: url)
            } else {
                productImageView.image = UIImage(systemName: "person")
            }
        } else {
            productImageView.image = UIImage(systemName: "person")
        }
    }
}
