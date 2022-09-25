//
//  MemoFooterView.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/21.
//

import UIKit

final class MemoFooterView: UIView {
    let memoWritingButton = UIButton()
    let memoCountLabel = UILabel()
    private var numberOfMemos = "0"

    init(_ numberOfMemos: String) {
        super.init(frame: CGRect(origin: .zero, size: .zero))
        self.numberOfMemos = numberOfMemos
        setMemoFooter()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MemoFooterView {
    private func setMemoFooter() {
        self.backgroundColor = UIColor(red: 247/255, green: 248/255, blue: 247/255, alpha: 1)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray.cgColor
        setMemoCountLabel()
        setMemoWritingButton()
    }

    private func setMemoCountLabel() {
        self.addSubview(memoCountLabel)
        memoCountLabel.text = "\(numberOfMemos)개의 메모"
        memoCountLabel.font = UIFont.systemFont(ofSize: 13)
        setMemoCountLabelLayout()
    }

    private func setMemoCountLabelLayout() {
        memoCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoCountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            memoCountLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 30),
        ])
    }

    private func setMemoWritingButton() {
        self.addSubview(memoWritingButton)
        memoWritingButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        setMemoWritingButtonLayout()
    }

    private func setMemoWritingButtonLayout() {
        memoWritingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoWritingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            memoWritingButton.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 30),
        ])
    }
}
