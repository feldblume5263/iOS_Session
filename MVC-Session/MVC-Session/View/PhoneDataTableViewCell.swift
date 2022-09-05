//
//  PhoneDataTableViewCell.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/05.
//

import UIKit

final class PhoneDataTableViewCell: UITableViewCell {
    
    public lazy var nameLabel = UILabel()
    public lazy var numberLabel = UILabel()
    public lazy var companyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PhoneDataTableViewCell {
    func setContents() {
        setNameLabel()
        setNumberLabel()
        setCompnayLabel()
    }
    
    func setNameLabel() {
        self.contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 80),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func setNumberLabel() {
        self.contentView.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 80),
            numberLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        numberLabel.textColor = .black
        numberLabel.font = UIFont.boldSystemFont(ofSize: 8)
    }
    
    func setCompnayLabel() {
        self.contentView.addSubview(companyLabel)
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            companyLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 20),
            companyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            companyLabel.widthAnchor.constraint(equalToConstant: 80),
            companyLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        companyLabel.textColor = .black
        companyLabel.font = UIFont.boldSystemFont(ofSize: 8)
    }
}
