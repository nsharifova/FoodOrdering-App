//
//  ProductViewModel.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 30.10.24.
//


import Foundation
class ProductViewModel {
    var products: [Product] = []
    var cartItems : [CartProduct] = []
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
    
    func updateCart(foodName: String, increment: Int) {
        if let index = cartItems.firstIndex(where: { $0.yemek_adi == foodName }) {
            if let currentCount = Int(cartItems[index].yemek_siparis_adet ?? "0") {
                cartItems[index].yemek_siparis_adet = String(currentCount + increment)
                self.success?()
                NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
            }
        }
    }

    
    func addToCard(foodName: String, foodImage: String, foodPrice: String, foodCount: Int, userName: String){
        
        
        manager.addToCard(foodName: foodName, foodImage: foodImage, foodPrice: foodPrice, foodCount: foodCount, userName: userName){ success ,error in
            if success {
                NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
                self.getCartItems(userName: userName)
                self.success?()
            }
            else if let error {
                self.failure?(error)
            }
            
        }
        
        
        
        
    }
    func deleteProduct(foodId: Int, userName: String){
        manager.deletePost(foodId: foodId, userName: userName) { success ,error in
            if success {
                self.getCartItems(userName: userName)
                self.success?()
                
            }
            else if let error {
                self.failure?(error)
            }
        }
    }
    func getCartItems(userName:String){
        manager.getCartItems(userName: userName){ items , error in
            if let data = items {
                self.cartItems = data
                self.success?()
                
            }
            
            else if let error {
                self.failure?(error)
            }
        }
    }
    
    
}
