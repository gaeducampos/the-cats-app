//
//  APICats.swift
//  Cat-APP
//
//  Created by Gabriel Campos on 25/5/23.
//

import Foundation

import Foundation
import Combine

final class APICats {
    private var networkPrivider: NetworkProvider
    
    init(networkPrivider: NetworkProvider) {
        self.networkPrivider = networkPrivider
    }
    
    func getCats() -> AnyPublisher<[Cat], Error> {
        var request = URLRequest(url: NetworkProvider.Constants.baseURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("x-api-key \(NetworkProvider.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return networkPrivider.request(for: request)
    }
    
    func getCatsImage(for imgId: String) -> AnyPublisher<CatImage, Error> {
        var request = URLRequest(url: NetworkProvider.Constants.imageURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("x-api-key \(NetworkProvider.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.url?.appendPathComponent(imgId)
        
        return networkPrivider.request(for: request)
        
    }
    
    
    
}
