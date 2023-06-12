//
//  ListViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/08.
//

import UIKit
import SnapKit
import Then
import RealmSwift

protocol MemoDelegate: AnyObject {
    func updateAllMemo(title: String, content: String?, dateCreated: Date, objectID: ObjectId )
    func updateSingleMemo(memo: Memo)
}

class MemoListViewController: BaseVC {
    
    let listView = MemoListView()
    let memoRepository = MemoRepository()
    
    lazy var makeMemoButton = UIButton().then {
        $0.backgroundColor = .cellTitleColor
        $0.layer.cornerRadius = 35.0
        $0.addTarget(self, action: #selector(makeMemoButtonTapped), for: .touchUpInside)
    }
    
    var query = String()
    var filterResult: Results<Memo>! {
        didSet {
            listView.tableView.reloadData()
        }
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching: Bool {
        get {
            return searchController.isActive
        }
    }
    
    var list: Results<Memo>! {
        didSet {
            listView.tableView.reloadData()
            self.navigationItem.title = "\(memoCountFormat(for: list.count))개의 메모"
        }
    }
    
    var pinList: Results<Memo>! {
        didSet {
            listView.tableView.reloadData()
        }
    }
    var unpinList: Results<Memo>! {
        didSet {
            listView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(makeMemoButton)
        
        makeMemoButton.snp.makeConstraints {
            $0.height.width.equalTo(70.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(100.0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if memoRepository.fetch() != list {
            fetchRealm()
        }
           
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = nil
    }

    override func configureUI() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        self.navigationItem.backButtonTitle = "메모"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        searchController.searchBar.placeholder = "검색"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func fetchRealm() {
        list = memoRepository.fetch()
        pinList = memoRepository.fetchPinnedMemo(true)
        unpinList = memoRepository.fetchPinnedMemo(false)
    }
    
    @objc func makeMemoButtonTapped(_ sender: UIBarButtonItem) {
        let vc = WriteViewController()
        vc.isEditing = true
        vc.editingMode = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterResult == nil ? 0 : filterResult.count
        } else {
            if pinList == nil || unpinList == nil {
                return 0
            }
            return section == 0 ? pinList.count : unpinList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let item = isSearching ? filterResult[indexPath.row] : (indexPath.section == 0 ? pinList[indexPath.row] : unpinList[indexPath.row])
        cell.textLabel?.text = item.title
        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
        
        let dateString: String = dateFormat(for: item.dateCreated).replacingOccurrences(of: "\n", with: "")
        
        var contentString = ""
        
        if let content = item.content {
            contentString = content.replacingOccurrences(of: "\n", with: "")
        }
        cell.detailTextLabel?.text = "\(dateString)  \(contentString)"
        
        cell.detailTextLabel?.textColor = .systemGray
        
        if isSearching {
            cell.detailTextLabel?.labelColorChange(query)
            cell.textLabel?.labelColorChange(query)

        }
        if contentString.isEmpty {
            cell.detailTextLabel?.text = "\(dateString)  추가 텍스트 없음"
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WriteViewController()
        vc.delegate = self
        vc.isEditing = false
        vc.editingMode = true
        if isSearching {
            self.navigationItem.backButtonTitle = "검색"
            let memo = filterResult[indexPath.row]
            vc.updateTextview(memo: memo)
            vc.editingMemo = memo
        } else {
            self.navigationItem.backButtonTitle = "메모"
            let memo = indexPath.section == 0 ? pinList[indexPath.row] : unpinList[indexPath.row]
            vc.updateTextview(memo: memo)
            vc.editingMemo = memo
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            let count = filterResult == nil ? 0 : filterResult.count
            return "\(count)개 찾음 "
        } else {
            if pinList != nil && pinList.count > 0 {
                return section == 0 ? "고정된 메모" : "메모"
            }
            else {
                return section == 0 ? nil : "메모"
            }
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.textColor = UIColor.label
        header.textLabel?.textAlignment = .left

    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pin = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            if self.memoRepository.fetchPinnedMemo(true).count == MemoPin.MaximumNumber && indexPath.section == 1 {
                self.showAlert(title: "고정메모는\n최대 \(MemoPin.MaximumNumber)개까지 가능합니다.", okText: "확인", cancelNeeded: false, completionHandler: nil)
                
                return
            } else {
                let item = indexPath.section == 0 ? self.pinList[indexPath.row] : self.unpinList[indexPath.row]
                self.memoRepository.updatePin(item)
                self.list = self.memoRepository.fetch()
                self.fetchRealm()
            }
            
        }
        let item = indexPath.section == 0 ? self.pinList[indexPath.row] : self.unpinList[indexPath.row]
        let pinImage = item.pinnedMemo ? "pin.slash.fill" : "pin.fill"
        pin.image = UIImage(systemName: pinImage)
        pin.backgroundColor = .black
        
        return UISwipeActionsConfiguration(actions: [ pin ])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            self.showAlert(title: "삭제하시겠습니까?", okText: "삭제", cancelNeeded: true) { action in
                let item = indexPath.section == 0 ? self.pinList[indexPath.row] : self.unpinList[indexPath.row]
                
                self.memoRepository.deleteMemo(item)
                self.fetchRealm()
            }
        }
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        
        self.query = query
        self.filterResult = memoRepository.fetchFilter(query)
    }
}

extension MemoListViewController: MemoDelegate {
    func updateAllMemo(title: String, content: String?, dateCreated: Date, objectID: ObjectId ) {
        self.memoRepository.updateMemo2(title: title, content: content, dateCreated: dateCreated, _id: objectID)
    }
    func updateSingleMemo(memo: Memo) {
        self.memoRepository.updateMemo(memo)
    }
}
