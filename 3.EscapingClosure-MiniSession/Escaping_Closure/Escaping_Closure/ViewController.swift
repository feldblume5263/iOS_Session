//
//  ViewController.swift
//  Escaping_Closure
//
//  Created by Noah Park on 2022/09/13.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var setCountButton: UIButton!
    
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = "Press Button"
        setCountButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
    }
    
    
    @objc func randomButtonPressed(_ sender: UIButton) {
        setRandomNumberButVerySpendLongTime()
        countLabel.text = count == 0 ? "Press Button" : "\(count)"
        count = 0
    }
}

private extension ViewController {
    func setRandomNumberButVerySpendLongTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.count = (1...100).randomElement()!
        }
    }
}
