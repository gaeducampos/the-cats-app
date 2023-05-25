//
//  NetworkProvider.swift
//  Cat-APP
//
//  Created by Gabriel Campos on 25/5/23.
//

import Foundation
import Combine

final class NetworkProvider {
    static let apiKey = "bda53789-d59e-46cd-9bc4-2936630fde39"
    
    enum NetworkingError: Error {
        case badURLResponse(url: String)
    }
    
    enum Constants {
        static let baseURL = URL(string: "https://api.thecatapi.com/v1/breeds")!
        static let imageURL = URL(string: "https://api.thecatapi.com/v1/images")!
    }
    
    func handleURLResponse(
        output: URLSession.DataTaskPublisher.Output,
        request: URLRequest
    ) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            print(output.response)
            throw NetworkingError.badURLResponse(url: request.url?.absoluteString ?? "")
        }
        return output.data
    }
    
    
    func request(for request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try self.handleURLResponse(output: $0, request: request)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func request<Value: Decodable>(
        for request: URLRequest,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Value, Error> {
        self.request(for: request)
            .decode(type: Value.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
}
