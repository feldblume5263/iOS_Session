//
//  MemoWritingViewController.swift
//  SimpleMemo
//
//  Created by taekkim on 2022/09/19.
//

import UIKit

protocol AddMemoViewDelegate: AnyObject {
    func addMemoAtTextView(memo: MemoItem)
}

final class AddMemoViewController: UIViewController {
    weak var delegate: AddMemoViewDelegate?
    private var memoTextView: UITextView!

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        memoTextView = UITextView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setMemoWritingView()
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(completeButtonPressed)), animated: true)
    }
}

extension AddMemoViewController {
    private func setMemoWritingView() {
        memoTextView.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(memoTextView)
        setMemoWritingViewLayout()
    }

    private func setMemoWritingViewLayout() {
        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoTextView.topAnchor.constraint(equalTo: view.topAnchor),
            memoTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            memoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            memoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
}

extension AddMemoViewController {
    @objc private func completeButtonPressed() {
        if let delegate {
            let memoText = memoTextView.text ?? ""
            if memoText.count > .zero {
                delegate.addMemoAtTextView(memo: MemoItem(text: memoText, createdDate: Date()))
                let sheet = UIAlertController(title: "Memo enrolled", message: "you saved the memo sucessfully", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in  }))
                present(sheet, animated: true)
            } else {
                let sheet = UIAlertController(title: "Data Error", message: "you need to fill something", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in  }))
                present(sheet, animated: true)
            }
        }
    }
}
