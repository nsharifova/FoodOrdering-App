//
//  APIManager.swift
//  FoodOrdering-App
//
//  Created by Nurluay Sharifova on 30.10.24.
//

import Foundation
import Alamofire
protocol NetworkService {
    func fetchData<T: Decodable>(urlPath: String,
                                 type: T.Type,
                                 method: HTTPMethod,
                                 parameters: [String: Any]?,
                                 completion: @escaping (Result<T, Error>) -> Void)
    func postData(urlPath:String,parameters:[String:Any],completion: @escaping (Result<Bool,Error>)->Void)
    
}

class Service : NetworkService {
    
    func fetchData<T: Decodable>(urlPath: String,
                                 type: T.Type,
                                 method: HTTPMethod = .get,
                                 parameters: [String: Any]? = nil,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(urlPath,method: method,parameters: parameters,encoding: URLEncoding.default).responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func postData(urlPath:String,parameters:[String:Any],completion: @escaping (Result<Bool,Error>)->Void){
        AF.request(urlPath,method: .post,parameters: parameters,encoding: URLEncoding.default).response { response in
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
        
    }
    
    
}

