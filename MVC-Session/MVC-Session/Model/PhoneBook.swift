//
//  DataRule.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/05.
//

import Foundation

enum OrderingOption {
    case name
    case company
}

final class PhoneBook {
    private var phoneDatas = Set<PhoneData>()
    
    func getPhoneDatasOrder(by option: OrderingOption) -> [PhoneData] {
        switch option {
        case .name:
            return phoneDatas.sorted {
                $0.name < $1.name
            }
        case .company:
            return phoneDatas.sorted {
                $0.company ?? "" < $1.company ?? ""
            }
        }
    }
    
    func setNewPhoneData(name: String, number: String, company: String?) {
        phoneDatas.insert(PhoneData(name: name, number: number, company: company))
    }
}
