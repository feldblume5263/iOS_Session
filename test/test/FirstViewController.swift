//
//  ViewController.swift
//  test
//
//  Created by Noah Park on 2022/09/15.
//

import UIKit

final class FirstViewController: UIViewController {
    
    @IBOutlet weak var forwardButton: UIButton!
    
    override func loadView() {
        super.loadView()
        print("firstView: load view")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("firstView: viewDidLoad")
        setForwardButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("firstView: viewWillAppear")
        forwardButton.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        print(forwardButton.frame.size)
    }
    
    override func viewWillLayoutSubviews() {
        print("firstView: viewWillLayoutSubviews")
        print(forwardButton.frame.size)
    }

    override func viewDidLayoutSubviews() {
        print("firstView: viewDidLayoutSubviews")
        print(forwardButton.frame.size)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("firstView: viewDidAppear")
        print(forwardButton.frame.size)
        forwardButton.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        print(forwardButton.frame.size)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("firstView: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("firstView: viewDidDisappear")
    }
}

private extension FirstViewController {
    func setForwardButton() {
        forwardButton.setTitle("Next", for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardButtonAction), for: .touchUpInside)
    }
    
    @objc func forwardButtonAction(_ sender: UIButton) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "secondView") {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
