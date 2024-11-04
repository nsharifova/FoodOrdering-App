//
//  HomeView.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 29.10.24.
//

import UIKit

class HomeView: BaseViewController {
    var productViewModel = ProductViewModel()
    private let searchField : UITextField = {
        let field = UITextField()
        field.placeholder = "Search"
        field.borderStyle = .line
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchField)
        view.addSubview(collectionView)
        setupConstraints()
        setupCollectionView()
        self.showActivityIndicator()
        
        productViewModel.getProducts()
        productViewModel.failure = { error in
            self.showErrorAlert(title: "Error", message: error)
            self.hideActivityIndicator()
        }
        productViewModel.success = {
            self.collectionView.reloadData()
            self.hideActivityIndicator()
        }
    }
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func setupConstraints() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30)
            
        ])
        
    }
    
}



extension HomeView : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModel.products.count
    }
 
  

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        let data = productViewModel.products[indexPath.row]
        cell.configure(data: data )
        cell.addToCard = { [weak self] in
            guard let self = self else { return }
            if let existingProduct = self.productViewModel.cartItems.first(where: { $0.yemek_adi == data.yemek_adi }) {
                self.productViewModel.updateCart(foodName: data.yemek_adi ?? "", increment: 1)
            } else {
                self.productViewModel.addToCard(foodName: data.yemek_adi ?? "", foodImage: data.yemek_resim_adi ?? "", foodPrice: String(data.yemek_fiyat ?? ""), foodCount: 1, userName: "Nurluay")
            }
        }


        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 2
        return CGSize(width: width, height: 200)
    }
}
