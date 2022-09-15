//
//  MyLabelView.swift
//  liveDelegatePattern
//
//  Created by Noah Park on 2022/09/15.
//

import UIKit

class MyLabelView: UIView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        setLayout()
        label.text = "\(50)"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
