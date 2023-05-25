//
//  File.swift
//  Cat-APP
//
//  Created by Gabriel Campos on 25/5/23.
//

import Foundation
import Combine


final class CatViewModel: ObservableObject {
    private var apiCats: APICats
    private var catsCancellable: AnyCancellable?
    private var catImageCancellable: AnyCancellable?
    
    init(apiCats: APICats) {
        self.apiCats = apiCats
    }
    
    @Published var cats: [Cat] = []
    @Published var catImage: CatImage?
    
    
    func getCats() {
        catsCancellable = apiCats
            .getCats()
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let cats):
                    self?.cats = cats
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    func getCatImage(for imageId: String) -> String {
        var imageURL = ""
        catImageCancellable = apiCats
            .getCatsImage(for: imageId)
            .toResult()
            .sink {  result in
                switch result {
                case .success(let catImageData):
                    imageURL = catImageData.url
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
        return imageURL
    }
    
}
