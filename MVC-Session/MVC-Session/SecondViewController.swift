//
//  SecondViewController.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/04.
//

import UIKit

final class SecondViewController: UIViewController {
    
    @IBOutlet weak var centerImage: UIImageView!
    
    override func loadView() {
        super.loadView()
        print("secondView: load view")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("secondView: viewDidLoad")
        setCenterImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("secondView: viewWillAppear")
    }
    
    override func viewWillLayoutSubviews() {
        print("secondView: viewWillLayoutSubviews")
//        print(centerImage.frame.size)
    }
    
    override func viewDidLayoutSubviews() {
        print("secondView: viewDidLayoutSubviews")
//        print(centerImage.frame.size)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("secondView: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("secondView: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("secondView: viewDidDisappear")
    }
}

private extension SecondViewController {
    func setCenterImage() {
        setCenterImageLayout()
        setCenterImageData()
    }
    func setCenterImageData() {
        centerImage.image = UIImage(named: "timcook")
    }
    
    func setCenterImageLayout() {
        centerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerImage.widthAnchor.constraint(equalToConstant: 200),
            centerImage.heightAnchor.constraint(equalToConstant: 200)
        ])
//        print("after set constraint:", centerImage.frame.size)
    }
}
