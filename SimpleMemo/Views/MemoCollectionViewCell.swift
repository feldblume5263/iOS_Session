//
//  MemoCollectionViewCell.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/19.
//

import UIKit

final class MemoCollectionViewCell: UICollectionViewCell {
    let previewImage = UIImageView()
    let title = UILabel()
    let createdDate = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setMemoCollectionViewCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MemoCollectionViewCell {
    private func setMemoCollectionViewCell() {
        setPreviewImage()
        setTitleLabel()
        setCreatedDateLabel()
    }

    private func setPreviewImage() {
        contentView.addSubview(previewImage)
        previewImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            previewImage.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }

    private func setTitleLabel() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: 10),
        ])
        title.font = UIFont.boldSystemFont(ofSize: 12)
    }

    private func setCreatedDateLabel() {
        contentView.addSubview(createdDate)
        createdDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createdDate.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createdDate.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
        ])
        createdDate.font = UIFont.systemFont(ofSize: 8)
    }
}
