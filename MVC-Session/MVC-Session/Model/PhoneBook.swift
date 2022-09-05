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

@objc final class PhoneBook: NSObject {
    @objc dynamic var phoneDatas = Set<PhoneData>()
    
    override init() {
        phoneDatas.insert(PhoneData(name: "Noasdaq", number: "12345678", "Microsoft"))
        phoneDatas.insert(PhoneData(name: "Taek", number: "2838273", "Kakao"))
        phoneDatas.insert(PhoneData(name: "Joy", number: "82338283", "Toss"))
        phoneDatas.insert(PhoneData(name: "Key", number: "3938484", "Naver"))
        phoneDatas.insert(PhoneData(name: "Nick", number: "193884", "Google"))
        phoneDatas.insert(PhoneData(name: "Sherry", number: "0938372", "Apple"))
        phoneDatas.insert(PhoneData(name: "Podding", number: "39834729", "Harvard"))
        phoneDatas.insert(PhoneData(name: "Ginger", number: "1948835", "Netflix"))
        phoneDatas.insert(PhoneData(name: "Mary", number: "5938483", "Linkedin"))
        phoneDatas.insert(PhoneData(name: "Murphy", number: "39838437", "Airbnb"))
        phoneDatas.insert(PhoneData(name: "Lance", number: "9438472", "Tesla"))
        phoneDatas.insert(PhoneData(name: "Rey", number: "32848349", "Uber"))
        phoneDatas.insert(PhoneData(name: "Meenu", number: "693848", "Facebook"))
        phoneDatas.insert(PhoneData(name: "Jack", number: "8434838", "Softbank"))
        phoneDatas.insert(PhoneData(name: "Woody", number: "392843", "Youtube"))
        phoneDatas.insert(PhoneData(name: "Woogy", number: "1944758", "Amazon"))
        phoneDatas.insert(PhoneData(name: "Ayden", number: "0983473", "Samsung"))
        phoneDatas.insert(PhoneData(name: "Yosep", number: "837472", "Line"))
    }
    
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
        phoneDatas.insert(PhoneData(name: name, number: number, company))
    }
}
