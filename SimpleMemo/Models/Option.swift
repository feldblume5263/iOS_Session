//
//  Option.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/21.
//

import Foundation

struct Option {
    private var viewOption = MemoViewOption.list
    private var sortOption = OrderingOption.createdDate
    private var optionItems = [["목록으로 보기", "갤러리로 보기"],
                       ["제목 순서로 메모 정렬", "생성일 순서로 메모 정렬", "무작위 순서로 메모 정렬"]]

    mutating func getOptions(of viewType: MemoViewOption) -> [[String]] {
        switch viewType {
        case .gallery:
            self.optionItems[0] = ["목록으로 보기"]
        case .list:
            self.optionItems[0] = ["갤러리로 보기"]
        }
        return optionItems
    }
}
