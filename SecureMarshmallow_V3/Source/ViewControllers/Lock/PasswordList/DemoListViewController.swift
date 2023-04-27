//
//  DemoListViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/27.
//

import UIKit

class ToDoViewController: UIViewController {

    private let toDoListView = DemoLockView()
    private let viewModel = LockViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toDoListView)
        setupNavigationBar()
        setupCollectionView()
        setupConstraints()
        prepareTaskList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func prepareTaskList() {
        viewModel.fetchTaskList()
        DispatchQueue.main.async { [weak self] in
            self?.toDoListView.collectionView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemIndigo
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .systemBackground
        navigationItem.title = "SecureMarshmallow"
    }
    
    private func setupCollectionView() {
        toDoListView.collectionView.dataSource = self
        toDoListView.collectionView.delegate = self
    }
    
//    @objc private func closeButtonTap() {
//        alertVC.dismiss(animated: true)
//    }
//
//    @objc private func addButtonTap() {
//        guard let title = customAlertView.textField.text, !title.isEmpty,
//              let details = customAlertView.detailsTextfield.text else { return }
//
//        viewModel.saveTask(title: title, details: details)
//        viewModel.fetchTaskList()
//        DispatchQueue.main.async { [weak self] in
//            self?.toDoListView.collectionView.reloadData()
//        }
//        alertVC.dismiss(animated: true)
//    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            toDoListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toDoListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toDoListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toDoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ToDoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.taskList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoLackCollectionCell.cellIdentifier, for: indexPath) as! DemoLackCollectionCell
        cell.titleLabel.text = viewModel.taskList[indexPath.row].title
        cell.detailsLabel.text = viewModel.taskList[indexPath.row].details
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 20
        return CGSize(
            width: width,
            height: width * 0.3)
    }
    
}


