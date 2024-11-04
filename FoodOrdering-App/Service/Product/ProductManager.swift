//
//  ProductManager.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 30.10.24.
//

import Foundation
class ProductManager {
    var service = Service()
    
    func getProducts(completion: @escaping (([Product]?, Error?) -> Void)) {
        service.fetchData(urlPath: PostEndpoint.product.url, type: FoodResponse.self) { result in
            switch result {
            case .success(let success):
                completion(success.yemekler, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
            
            
        }
        
    }
    
    func addToCard(foodName:String,foodImage:String,foodPrice:String,foodCount:Int,userName:String, completion: @escaping (Bool,String?)->Void){
        let parameters : [String:Any] = [
            "yemek_adi": foodName,
            "yemek_resim_adi": foodImage,
            "yemek_fiyat": foodPrice,
            "yemek_siparis_adet": foodCount,
            "kullanici_adi": userName
        ]
        service.postData(urlPath: PostEndpoint.addProduct.url, parameters: parameters){ result in
            switch result {
            case .success:
                completion(true,nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
                
            }
            
        }
    }
    func deletePost(foodId:Int,userName:String,completion: @escaping (Bool,String?)->Void){
        let parameters : [String:Any] = [
            "sepet_yemek_id" : foodId,
            "kullanici_adi"  : userName
        ]
        service.postData(urlPath: PostEndpoint.deleteProduct.url, parameters: parameters) { result in
            switch result {
            case .success:
                completion(true,nil)
            case .failure(let error):
                completion(false,error.localizedDescription)
            }
            
            
        }
    }
    
    func getCartItems (userName:String,completion: @escaping ([CartProduct]?,String?)->Void) {
        let parameters: [String: Any] = [
            "kullanici_adi": userName
        ]
        service.fetchData(urlPath:PostEndpoint.getProducInCard.url,type: CartResponse.self, method:.post, parameters:parameters) { result in
            switch result {
            case .success(let data):
                completion(data.sepet_yemekler, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    
    
}
