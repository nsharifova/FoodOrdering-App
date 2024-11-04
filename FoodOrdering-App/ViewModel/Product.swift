//
//  Product.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 30.10.24.
//

import Foundation
class ProductViewModel {
    var products: [Product] = []
    let manager = ProductManager()
    
    var success: (() -> Void)?
    var failure: ((String) -> Void)?
    
    func getProducts() {
        manager.getProducts { items, error in
            if let error {
                self.failure?(error.localizedDescription)
            } else if let items {
                self.products = items
                self.success?()
            }
        }
    }
}
