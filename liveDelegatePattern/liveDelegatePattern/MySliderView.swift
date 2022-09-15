//
//  MySliderView.swift
//  liveDelegatePattern
//
//  Created by Noah Park on 2022/09/15.
//

import UIKit

protocol MysliderViewDelegate: AnyObject {
    func sliderValueChanged(newValue: Int)
}

class MySliderView: UIView {

    let slider = UISlider()
    weak var delegate: MysliderViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(slider)
        setLayout()
        setSlider()
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.heightAnchor.constraint(equalToConstant: 20),
            slider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            slider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func setSlider() {
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.value = 50
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        if let delegate = delegate {
            delegate.sliderValueChanged(newValue: Int(slider.value))
        }
    }
}
