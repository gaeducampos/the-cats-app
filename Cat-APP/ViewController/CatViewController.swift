//
//  ViewController.swift
//  Cat-APP
//
//  Created by Gabriel Campos on 25/5/23.
//

import UIKit
import SwiftUI

class CatViewController: UIViewController {
    let viewModel = CatViewModel(apiCats: .init(networkPrivider: .init()))
    
    lazy var catUIHostinController: UIHostingController = {
        let catview = UIHostingController(rootView: CatView(viewModel: viewModel))
        catview.view.translatesAutoresizingMaskIntoConstraints = false
        catview.view.backgroundColor = .systemBackground
        catview.view.overrideUserInterfaceStyle = .light
        return catview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        addChild(catUIHostinController)
        view.addSubview(catUIHostinController.view)
        viewModel.getCats()
        setUpConstraints()

    }
    
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            catUIHostinController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catUIHostinController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            catUIHostinController.view.topAnchor.constraint(equalTo: view.topAnchor),
            catUIHostinController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    

    
}




