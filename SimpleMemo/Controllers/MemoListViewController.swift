//
//  ViewController.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/15.
//

import UIKit

// FIXME: 스크롤할때 LargeTitle 영역 침범하는 버그 있음
final class MemoListViewController: UIViewController, UISheetPresentationControllerDelegate {
    lazy private var memo = Memo()
    private var option = Option()
    private var memoTableView: UITableView!
    private var memoCollectionView: UICollectionView!
    private var observer: NSKeyValueObservation!
    private var memoFooterView: MemoFooterView!
    private var currentOrderOption: OrderingOption = .createdDate
    private var currentViewOption: MemoViewOption = .list

    lazy private var memos: [MemoItem] = [] {
        willSet {
            switch currentViewOption {
            case .list:
                memoTableView.reloadData()
            case .gallery:
                memoCollectionView.reloadData()
            }
        }
    }

    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        memoTableView = UITableView(frame: .zero, style: .insetGrouped)
        memoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        memos = memo.getOrderedMemoItems(by: currentOrderOption)
        setMemoFooterView()
        setMemoView()
        setMemoObserverToViewController()

    }

    override func viewWillAppear(_ animated: Bool) {
        memos = memo.getOrderedMemoItems(by: currentOrderOption)
    }
}

// MARK: - Button
extension MemoListViewController {
    @objc private func tapMemoWrtingButton() {
        let controller = AddMemoViewController()
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func addTapped() {
        let viewControllerToPresent = OptionListViewController()
        // TODO: iOS 15 미만 버전으로 바꿔보기
        viewControllerToPresent.options = option.getOptions(of: currentViewOption)
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium()]
            viewControllerToPresent.delegate = self
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
}

// MARK: - Table View
extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: convet to custom cell
        let memo = memos[indexPath.row]
        let cell = memoTableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        content.text = memo.title
        content.secondaryText = "\(memo.getCreatedDate()) \(memo.content)"
        cell.contentConfiguration = content

        return cell
    }
}

extension MemoListViewController {
    private func setMemoTableView() {
        memoTableView.dataSource = self
        memoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "memoCell")
    }

    private func setMemoTableViewLayout() {
        memoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            memoTableView.bottomAnchor.constraint(equalTo: memoFooterView.topAnchor),
            memoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            memoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - Collection View
extension MemoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let memo = memos[indexPath.row]
        let cell = memoCollectionView.dequeueReusableCell(withReuseIdentifier: "memoCollectionCell", for: indexPath) as? MemoCollectionViewCell ?? UICollectionViewCell()
        let image = UIImage(named: "god")
        (cell as? MemoCollectionViewCell)?.previewImage.image = image
        (cell as? MemoCollectionViewCell)?.title.text = memo.title
        (cell as? MemoCollectionViewCell)?.createdDate.text = memo.getCreatedDate()

        return cell
    }
}

extension MemoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 30) / 3, height: (view.frame.width + 100) / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension MemoListViewController {
    private func setMemoCollectionView() {
        memoCollectionView.backgroundColor = .systemGroupedBackground
        memoCollectionView.dataSource = self
        memoCollectionView.delegate = self
        memoCollectionView.register(MemoCollectionViewCell.self, forCellWithReuseIdentifier: "memoCollectionCell")
    }

    private func setMemoCollectionViewLayout() {
        memoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            memoCollectionView.bottomAnchor.constraint(equalTo: memoFooterView.topAnchor),
            memoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            memoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - Convert View Delegate
extension MemoListViewController: ConvertViewDelegate {
    func convertMemoView() {
        switch currentViewOption {
        case .list:
            memoTableView.removeFromSuperview()
            view.addSubview(memoCollectionView)
            setMemoCollectionViewLayout()
            memoCollectionView.reloadData()
            currentViewOption = .gallery
        case .gallery:
            memoCollectionView.removeFromSuperview()
            view.addSubview(memoTableView)
            setMemoTableViewLayout()
            memoTableView.reloadData()
            currentViewOption = .list
        }
    }
    func sortMemo(by option: OrderingOption) {
        memos = memo.getOrderedMemoItems(by: option)
    }
}


// MARK: - Add Memo Delegate
extension MemoListViewController: AddMemoViewDelegate {
    func addMemoAtTextView(memo: MemoItem) {
        self.memo.addMemoItem(memo)
    }
}

// MARK: - Memo Footer View
extension MemoListViewController {
    private func setMemoView() {
        self.title = "메모"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(addTapped))
        view.addSubview(memoTableView)
        setMemoTableView()
        setMemoCollectionView()
        setMemoTableViewLayout()

    }

    private func setMemoFooterView() {
        memoFooterView = MemoFooterView("\(memos.count)")
        memoFooterView.memoWritingButton.addTarget(self, action: #selector(tapMemoWrtingButton), for: .touchUpInside)
        view.addSubview(memoFooterView)
        setMemoFooterViewLayout()
    }

    private func setMemoFooterViewLayout() {
        memoFooterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoFooterView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            memoFooterView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            memoFooterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            memoFooterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - KVO
extension MemoListViewController {
    private func setMemoObserverToViewController() {
        observer = memo.observe(\.memoItems, options: .new) { (_, _) in
            self.memos = self.memo.getOrderedMemoItems(by: self.currentOrderOption)
            self.memoFooterView.memoCountLabel.text = "\(self.memos.count)개의 메모"
        }
    }
}
