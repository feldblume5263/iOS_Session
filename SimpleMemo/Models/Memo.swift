//
//  Memo.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/15.
//

import Foundation

enum OrderingOption: Int {
    case title = 0
    case createdDate
    case random
}

enum MemoViewOption: Int {
    case list = 0
    case gallery
}


final class Memo: NSObject, Codable {
    @objc dynamic var memoItems = Set<MemoItem>()

    override init() {
        super.init()
        memoItems = readFromJson()
    }

    func getOrderedMemoItems(by option: OrderingOption) -> [MemoItem] {
        switch option {
        case .title:
            return memoItems.sorted {
                $0.title < $1.title
            }
        case .createdDate:
            return memoItems.sorted {
                $0.createdDate < $1.createdDate
            }
        case .random:
            return Array(memoItems).shuffled()
        }
    }

    func addMemoItem(_ item: MemoItem) {
        memoItems.insert(item)
        self.saveModelToJson()
    }

    private func readFromJson() -> Set<MemoItem> {
        do {
            let url = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("memos.json")

            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Memo.self, from: data)
            return jsonData.memoItems
        } catch {
            print("Something went very wrong")
        }
        return []
    }


    private func saveModelToJson() {
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("memos.json")

            let data = try JSONEncoder().encode(self)
            try data.write(to: fileURL)
        } catch {
            print("Error writing to JSON file: \(error)")
        }
    }
}
