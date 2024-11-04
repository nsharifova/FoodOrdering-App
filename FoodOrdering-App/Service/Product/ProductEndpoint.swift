//
//  ProductEndpoint.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 30.10.24.
//

import Foundation
enum PostEndpoint {
    case product
    case addProduct
    case getProducInCard
    case deleteProduct
    
    var url: String {
        switch self {
        case .product:
            return "\(Constants.apiUrl)/tumYemekleriGetir.php"
    
        case .addProduct:
            return "\(Constants.apiUrl)/sepeteYemekEkle.php"
        case .getProducInCard:
            return "\(Constants.apiUrl)/sepettekiYemekleriGetir.php"
        case .deleteProduct:
            return "\(Constants.apiUrl)/sepettenYemekSil.php"
        
 
    }
        
    }
}
