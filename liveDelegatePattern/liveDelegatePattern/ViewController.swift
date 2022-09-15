//
//  ViewController.swift
//  liveDelegatePattern
//
//  Created by Noah Park on 2022/09/15.
//

import UIKit

class ViewController: UIViewController {

    var countLabelView: MyLabelView!
    var countSliderView: MySliderView!
    
    var count = 50 {
        didSet {
            self.countLabelView.label.text = "\(count)"
        }
    }

    
    override func loadView() {
        super.loadView()
        countLabelView = MyLabelView(frame: .zero)
        countSliderView = MySliderView(frame: .zero)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(countLabelView)
        view.addSubview(countSliderView)
        setComponentsLayout()
        countSliderView.delegate = self
    }
    


}

extension ViewController: MysliderViewDelegate {
    func sliderValueChanged(newValue: Int) {
        count = newValue
    }
    
    
    
    
}

private extension ViewController {
    func setComponentsLayout() {
        countLabelView.translatesAutoresizingMaskIntoConstraints = false
        countSliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countLabelView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            countLabelView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            countLabelView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            countLabelView.heightAnchor.constraint(equalToConstant: 200),
            countSliderView.topAnchor.constraint(equalTo: self.countLabelView.bottomAnchor, constant: 100),
            countSliderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            countSliderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            countSliderView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}

