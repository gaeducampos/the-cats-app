//
//  CatView.swift
//  Cat-APP
//
//  Created by Gabriel Campos on 25/5/23.
//

import SwiftUI

struct CatView: View {
    let viewModel: CatViewModel
    
    init(viewModel: CatViewModel) {
        self.viewModel = viewModel
    }
    
    
    
    var body: some View {
        VStack {
            Text("CatBreeds")
            ForEach(viewModel.cats) { cat in
                Text(cat.name)
                AsyncImage(url: URL(string: viewModel.getCatImage(for: cat.reference_image_id)), scale: 2)
                    .frame(maxWidth: 250, maxHeight: 250)
                
                HStack {
                    Text("Origen: \(cat.origin)")
                    Text("Inteligencia  \(cat.intelligence)")
                }
                
            }
        }
    }
}


struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView(viewModel: .init(apiCats: .init(networkPrivider: .init())))
    }
}
