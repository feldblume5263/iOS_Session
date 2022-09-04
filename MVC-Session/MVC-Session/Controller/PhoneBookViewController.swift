//
//  ViewController.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/03.
//

import UIKit

final class PhoneBookViewController: UIViewController {
    
    lazy private var phoneBook = PhoneBook()
    private var phoneDataList: PhoneDataListTableView!
    private var listOptionButton: UIButton!
    private var addDataButton: UIButton!
    private var currentOption: OrderingOption = .name {
        didSet(newVal) {
            switch newVal {
            case .name:
                listOptionButton.setTitle("이름", for: .normal)
            case .company:
                listOptionButton.setTitle("회사", for: .normal)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        phoneDataList = PhoneDataListTableView()
        listOptionButton = UIButton()
        addDataButton = UIButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPhoneDataList()
        setListOptionButton()
        setAddDataButton()
    }
}

private extension PhoneBookViewController {
    func setListOptionButton() {
        self.view.addSubview(listOptionButton)
        setListOptionButtonLayout()
        listOptionButton.addTarget(self, action: #selector(listOptionButtonAction), for: .touchUpInside)
        listOptionButton.setTitle("이름", for: .normal)
        listOptionButton.setTitleColor(.black, for: .normal)
    }
    
    func setListOptionButtonLayout() {
        listOptionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listOptionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            listOptionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            listOptionButton.widthAnchor.constraint(equalToConstant: 200),
            listOptionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func listOptionButtonAction(_ sender: UIButton) {
        if self.currentOption == .name {
            currentOption = .company
        } else if self.currentOption == .company {
            currentOption = .name
        }
    }
}

private extension PhoneBookViewController {
    func setAddDataButton() {
        self.view.addSubview(addDataButton)
        setAddDataButtonLayout()
        addDataButton.addTarget(self, action: #selector(AddDataButtonAction), for: .touchUpInside)
        addDataButton.setTitle("추가", for: .normal)
        addDataButton.setTitleColor(.black, for: .normal)
    }
    
    func setAddDataButtonLayout() {
        addDataButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addDataButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            addDataButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            addDataButton.widthAnchor.constraint(equalToConstant: 200),
            addDataButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func AddDataButtonAction(_ sender: UIButton) {
        phoneBook.setNewPhoneData(name: "someone", number: "010-1234-5678", company: "ADA")
    }
}

extension PhoneBookViewController: PhoneDataListTableViewDelegate {
    private func setPhoneDataList() {
        phoneDataList.ownDelegate = self
        phoneDataList.delegate = self
        self.view.addSubview(phoneDataList)
        setPhoneDataListLayout()
    }
    
    private func setPhoneDataListLayout() {
        phoneDataList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneDataList.topAnchor.constraint(equalTo: self.view.topAnchor),
            phoneDataList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            phoneDataList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            phoneDataList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension PhoneBookViewController: UITableViewDelegate {
    
}

extension PhoneBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}



