//
//  CardView.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 29.10.24.
//

import UIKit

class CardView: BaseViewController {
    var productViewModel = ProductViewModel()
    let tableView =  UITableView()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "Total"
        return label
    }()
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(priceLabel)
        view.addSubview(confirmButton)
        view.addSubview(tableView)
        setupConstraints()
        setupTableView()
        self.showActivityIndicator()
       NotificationCenter.default.addObserver(self, selector: #selector(refreshCartItems), name: NSNotification.Name("CartUpdated"), object: nil)

        productViewModel.getCartItems(userName: "Nurluay")
        productViewModel.success = {
            self.hideActivityIndicator()

            let totalPrice = self.productViewModel.cartItems.reduce(0) { (result, cartItem) in
                let price = Double(cartItem.yemek_fiyat ?? "0") ?? 0.0
                return result + price
            }

            self.priceLabel.text = String(format: "%.2f", totalPrice)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
        productViewModel.failure = { error in
            self.hideActivityIndicator()
            self.showErrorAlert(title: "Error", message: error)

        }
     

    }
    @objc func refreshCartItems() {
        productViewModel.getCartItems(userName: "Nurluay")
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "CardTableViewCell")
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -20),
            
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -20),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),

            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            
           
            
            
        ])
        
    }

}
extension CardView : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell") as! CardTableViewCell
        let data = productViewModel.cartItems[indexPath.row]
        cell.configure(data:data)
        cell.deleteProduct = { [weak self] in
            guard let self = self else {return}
            productViewModel.deleteProduct(foodId: Int(data.sepet_yemek_id ?? "") ?? 0, userName: data.kullanici_adi ?? "")
            productViewModel.cartItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
           return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
       
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           return 10
       }


    
    
}
