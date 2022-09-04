//
//  PhoneDataListTableView.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/05.
//

import UIKit

protocol PhoneDataListTableViewDelegate: AnyObject {
    
}

final class PhoneDataListTableView: UITableView {

    weak var ownDelegate: PhoneDataListTableViewDelegate?
}
