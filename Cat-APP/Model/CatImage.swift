//
//  CatImage.swift
//  Cat-APP
//
//  Created by Gabriel Campos on 25/5/23.
//

import Foundation

struct CatImage: Decodable {
    let id: String
    let url: String
    let breeds: [Cat]
    let width: Int
    let height: Int
}
