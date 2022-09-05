//
//  Phone.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/05.
//

import Foundation

@objc class PhoneData: NSObject {
    var name: String
    var number: String
    var company: String?
    
    init(name: String, number: String, _ company: String?) {
        self.name = name
        self.number = number
        self.company = company
    }
}
