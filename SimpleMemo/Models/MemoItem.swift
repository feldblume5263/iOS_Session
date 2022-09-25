//
//  MemoItem.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/15.
//

import Foundation

final class MemoItem: NSObject, Codable {
    private let text: String
    let createdDate: Date
    lazy var title = setTitle()
    lazy var content = setContent()

    init(text: String, createdDate: Date) {
        self.text = text
        self.createdDate = createdDate
    }
}

extension MemoItem {
    // TODO: 오늘 적은 것은 다르게 반영
    func getCreatedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.M.d"
        return formatter.string(from: createdDate)
    }

    private func setTitle() -> String {
        let splitedText = text.split(separator: "\n")
        guard splitedText.count > 0 else { return "" }
        return String(splitedText[0])
    }

    private func setContent() -> String {
        let splitedText = text.split(separator: "\n")
        guard splitedText.count > 1 else { return "" }
        return String(splitedText[1])
    }
}
