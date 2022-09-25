//
//  OptionTableViewCell.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/22.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    let optionLabel = UILabel()
    let optionImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setOptionLabel()
        setOptionImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension OptionTableViewCell {
    private func setOptionLabel() {
        contentView.addSubview(optionLabel)
        optionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        setOptionLabelLayout()
    }

    private func setOptionLabelLayout() {
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
    }

    private func setOptionImage() {
        contentView.addSubview(optionImageView)
        setOptionImageLayout()
    }

    private func setOptionImageLayout() {
        optionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            optionImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}
