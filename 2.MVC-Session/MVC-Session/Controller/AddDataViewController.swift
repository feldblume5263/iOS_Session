//
//  AddDataViewController.swift
//  MVC-Session
//
//  Created by Noah Park on 2022/09/05.
//

import UIKit

protocol AddDataViewDelegate: AnyObject {
    func addDataAtForm(data: PhoneData)
}

final class AddDataViewController: UIViewController {
    private var nameTextField: UITextField!
    private var numberTextField: UITextField!
    private var companyTextField: UITextField!
    weak var delegate: AddDataViewDelegate? = nil
    
    override func loadView() {
        super.loadView()
        nameTextField = UITextField()
        numberTextField = UITextField()
        companyTextField = UITextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add People"
        setTextFields()
        setCompleteButtonItem()
    }
    
}

private extension AddDataViewController {
    func setCompleteButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Complete", style: .done, target: self, action: #selector(completeButtonPressed))
    }
    
    @objc func completeButtonPressed(_ sender: UIBarButtonItem) {
        if let delegate = delegate {
            let name = nameTextField.text ?? ""
            let number = numberTextField.text ?? ""
            if name.count > .zero && number.count > .zero {
                delegate.addDataAtForm(data: PhoneData(name: name, number: number, companyTextField.text))
                _ = navigationController?.popViewController(animated: true)
            } else {
                let sheet = UIAlertController(title: "Data Error", message: "you need name and number", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in  }))
                present(sheet, animated: true)
            }
        }
    }
    
    func setTextFields() {
        self.view.addSubview(nameTextField)
        nameTextField.placeholder = "Name"
        self.view.addSubview(numberTextField)
        numberTextField.placeholder = "Number"
        self.view.addSubview(companyTextField)
        companyTextField.placeholder = "Company"
        setNameTextFieldLayout()
        setNumberTextFieldLayout()
        setCompanyTextFieldLayout()
    }
}

private extension AddDataViewController {
    func setNameTextFieldLayout() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            nameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setNumberTextFieldLayout() {
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            numberTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            numberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 100),
            numberTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setCompanyTextFieldLayout() {
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            companyTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            companyTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            companyTextField.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 100),
            companyTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
