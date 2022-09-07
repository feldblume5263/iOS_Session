//
//  MainFloatingButton.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/06.
//

import UIKit

final class MainFloatingButton: UIButton {
    
    init(title: String) {
        super.init(frame: CGRect(origin: .zero, size: .zero))
        self.layer.cornerRadius = 10.0
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
