//
//  Product.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 30.10.24.
//

import Foundation
struct Product : Codable {
    var yemek_adi : String?
    var yemek_resim_adi : String?
    var yemek_fiyat : String?
    
    
}
struct FoodResponse: Codable {
    let yemekler: [Product]
    let success: Int
}

struct CartResponse: Codable {
    let sepet_yemekler: [CartProduct]?
}

struct CartProduct: Codable {
    let sepet_yemek_id: String?
    let yemek_adi: String?
    let yemek_resim_adi: String?
    let yemek_fiyat: String?
    var yemek_siparis_adet: String?
    let kullanici_adi: String?
}
