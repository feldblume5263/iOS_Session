//
//  ViewController.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/03.
//

import UIKit

final class PhoneBookViewController: UIViewController {
    lazy private var phoneBook = PhoneBook()
    private var dataTableView: UITableView!
    private var observer: NSKeyValueObservation!
    private var listOptionButton: MainFloatingButton!
    private var addDataButton: MainFloatingButton!
    lazy private var datas: [PhoneData] = [] {
        didSet {
            dataTableView.reloadData()
        }
    }
    private var currentOption: OrderingOption = .name {
        didSet {
            switch currentOption {
            case .name:
                listOptionButton.setTitle("Name", for: .normal)
                datas = phoneBook.getPhoneDatasOrder(by: self.currentOption)
            case .company:
                listOptionButton.setTitle("Company", for: .normal)
                datas = phoneBook.getPhoneDatasOrder(by: self.currentOption)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        dataTableView = UITableView()
        listOptionButton = MainFloatingButton(title: "Name")
        addDataButton = MainFloatingButton(title: "Add")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NameBook"
        setDataTableView()
        setListOptionButton()
        setAddDataButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        datas = phoneBook.getPhoneDatasOrder(by: currentOption)
    }
}

private extension PhoneBookViewController {
    func setListOptionButton() {
        self.view.addSubview(listOptionButton)
        setListOptionButtonLayout()
        listOptionButton.addTarget(self, action: #selector(listOptionButtonAction), for: .touchUpInside)
    }
    
    @objc func listOptionButtonAction(_ sender: UIButton) {
        if self.currentOption == .name {
            currentOption = .company
        } else if self.currentOption == .company {
            currentOption = .name
        }
    }
}

extension PhoneBookViewController: AddDataViewDelegate {
    private func setAddDataButton() {
        self.view.addSubview(addDataButton)
        setAddDataButtonLayout()
        addDataButton.addTarget(self, action: #selector(AddDataButtonAction), for: .touchUpInside)
    }
    
    @objc private func AddDataButtonAction(_ sender: UIButton) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "addDataView") as? AddDataViewController {
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func addDataAtForm(data: PhoneData) {
        phoneBook.setNewPhoneData(name: data.name, number: data.number, company: data.company)
    }
}

extension PhoneBookViewController {
    private func setDataTableView() {
        dataTableView.dataSource = self
        dataTableView.register(PhoneDataTableViewCell.classForCoder(), forCellReuseIdentifier: "dataCell")
        self.view.addSubview(dataTableView)
        setDataTableViewLayout()
        setPhoneBookObserverToDataTableView()
    }
    
    private func setPhoneBookObserverToDataTableView() {
        observer = phoneBook.observe(\.phoneDatas) { (data, change) in
            //
            self.datas = self.phoneBook.getPhoneDatasOrder(by: self.currentOption)
            //
        }
    }
}

extension PhoneBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let cell = dataTableView.dequeueReusableCell(withIdentifier: "dataCell") as? PhoneDataTableViewCell ?? UITableViewCell()
        
        (cell as? PhoneDataTableViewCell)?.nameLabel.text = data.name
        (cell as? PhoneDataTableViewCell)?.numberLabel.text = data.number
        (cell as? PhoneDataTableViewCell)?.companyLabel.text = data.company
        return cell
    }
}

private extension PhoneBookViewController {
    func setAddDataButtonLayout() {
        addDataButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addDataButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            addDataButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            addDataButton.widthAnchor.constraint(equalToConstant: 100),
            addDataButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setListOptionButtonLayout() {
        listOptionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listOptionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            listOptionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            listOptionButton.widthAnchor.constraint(equalToConstant: 100),
            listOptionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setDataTableViewLayout() {
        dataTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dataTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            dataTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            dataTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            dataTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
