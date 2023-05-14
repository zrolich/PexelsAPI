//
//  NetworkDataFetch.swift
//  PexelsAPI
//
//  Created by Zhanna Rolich on 19.12.2022.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init () {}
    
    func searchImage(query: String, page:Int, response: @escaping (GalleryModel?, Error?) -> Void){
        
        guard let url = URL(string: baseApiURL + "search") else {return}
        
        let queryItems = [URLQueryItem(name: "per_page", value: String(perPage)),
                          URLQueryItem(name: "query", value: query),
                          URLQueryItem(name: "page", value: String(page))]
        
        let newUrl = url.appending(queryItems: queryItems)
        
        NetworkRequest.shared.requestData(url: newUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let gallery = try JSONDecoder().decode(GalleryModel.self, from: data)
                    response(gallery, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requestinf data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
}

