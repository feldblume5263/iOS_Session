//
//  OptionListViewController.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/15.
//

import UIKit

protocol ConvertViewDelegate: AnyObject {
    func convertMemoView()
    func sortMemo(by option: OrderingOption)
}

final class OptionListViewController: UIViewController {
    weak var delegate: ConvertViewDelegate?

    private var optionTableView: UITableView!
    private var dismissButton: UIButton!
    private var viewOptionHeader: UILabel!

    lazy private var newViewOption = setNewViewOption()
    lazy var options: [[String]] = []

    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        optionTableView = UITableView(frame: .zero, style: .insetGrouped)
        viewOptionHeader = UILabel(frame: .zero)
        dismissButton = UIButton(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        view.tintColor = .systemGray
        setDismissButton()
        setViewOptionLabel()
        setOptionTableView()
    }
}


// MARK: - Data Source
extension OptionListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        options.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options[indexPath.section][indexPath.row]
        let cell = optionTableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as? OptionTableViewCell ?? UITableViewCell()
        (cell as? OptionTableViewCell)?.optionLabel.text = option
        if indexPath.section == 0,
           indexPath.row == 0 {
            let symbolConfiguration = UIImage.SymbolConfiguration(paletteColors: [.black])
            switch newViewOption {
            case .gallery:
                (cell as? OptionTableViewCell)?.optionImageView.image = UIImage(systemName: "square.grid.2x2", withConfiguration: symbolConfiguration)
            case .list:
                (cell as? OptionTableViewCell)?.optionImageView.image = UIImage(systemName: "list.bullet", withConfiguration: symbolConfiguration)
            }
        }

        return cell
    }
}


// MARK: - Delegate
extension OptionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0,
           indexPath.row == 0 {
            self.delegate?.convertMemoView()
        } else {
            guard let option = OrderingOption(rawValue: indexPath.row) else { return }
            self.delegate?.sortMemo(by: option)
        }
        self.dismiss(animated: true)
    }
}

// MARK: - View & Layout
extension OptionListViewController {
    private func setOptionTableView() {
        optionTableView.dataSource = self
        optionTableView.delegate = self
        optionTableView.register(OptionTableViewCell.self, forCellReuseIdentifier: "optionCell")
        view.addSubview(optionTableView)
        setMemoTableViewLayout()
    }

    private func setMemoTableViewLayout() {
        optionTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionTableView.topAnchor.constraint(equalTo: self.viewOptionHeader.bottomAnchor),
            optionTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            optionTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            optionTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }

    private func setDismissButton() {
        dismissButton.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        // TODO: ellipsis 색깔 바꾸기
        dismissButton.addTarget(self, action: #selector(tapToDismiss), for: .touchUpInside)
        view.addSubview(dismissButton)
        setDismissButtonLayout()
    }

    private func setDismissButtonLayout() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    private func setViewOptionLabel() {
        viewOptionHeader.text = "보기 옵션"
        viewOptionHeader.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.addSubview(viewOptionHeader)
        setViewOptionLabelLayout()
    }

    private func setViewOptionLabelLayout() {
        viewOptionHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewOptionHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewOptionHeader.topAnchor.constraint(equalTo: dismissButton.bottomAnchor),
        ])
    }
}

// MARK: - Functions
extension OptionListViewController {
    private func setNewViewOption() -> MemoViewOption {
        guard let newViewOption = options.first?.first else { return .gallery }
        if newViewOption == "목록으로 보기" {
            return .list
        } else {
            return .gallery
        }
    }

    @objc private func tapToDismiss() {
        self.dismiss(animated: true)
    }
}

