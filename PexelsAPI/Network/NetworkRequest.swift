//
//  NetworkRequest.swift
//  PexelsAPI
//
//  Created by Zhanna Rolich on 19.12.2022.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
    
    func requestData(url: URL, completion: @escaping (Result<Data, Error>) -> Void ){
        
        var request = URLRequest(url: url)
        request.setValue(headerValue, forHTTPHeaderField: headerKey)
  
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                completion(.success(data))
            }
        }
        .resume()
    
}

    
}
