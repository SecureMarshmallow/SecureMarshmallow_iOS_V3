import UIKit
import SnapKit
import Then
import RealmSwift

enum Section {
    case pinned
    case unpinned
    case search
}

typealias Item = Memo

class FixListViewController: BaseVC {
    let mainView = FixListView()
    let repository = MemoRepository()
    
    var query = String()
    var filterResult: Results<Memo>!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearching: Bool {
        get {
            let searchable = searchController.isActive
            navigationItem.backButtonTitle = searchable ? "검색" : "메모"
            return searchable
        }
    }
    
    var list: Results<Memo>! {
        didSet {
            self.navigationItem.title = "\(memoCountFormat(for: list.count))개의 메모"
            
            self.configureDataSource()
        }
    }
    
    var pinList: Results<Memo>!
    var unpinList: Results<Memo>!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if repository.fetch() != list {
            fetchRealm()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = nil
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.collectionViewLayout = createLayout()
        configureDataSource()
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
        
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.backgroundColor = .systemBackground
        let makeMemoButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(makeMemoButtonTapped))
        makeMemoButton.tintColor = .systemOrange
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        self.toolbarItems = [flexibleSpace, makeMemoButton]
    }
    
    func fetchRealm() {
        list = repository.fetch()
        pinList = repository.fetchPinnedMemo(true)
        unpinList = repository.fetchPinnedMemo(false)
    }
    
    @objc func makeMemoButtonTapped(_ sender: UIBarButtonItem) {
        let vc = WriteViewController()
        vc.isEditing = true
        vc.editingMode = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FixListViewController {
    private func createLayout() -> UICollectionViewLayout {
        
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.leadingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
            let pin = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
                if self.repository.fetchPinnedMemo(true).count == MemoPin.MaximumNumber && indexPath.section == 1 {
                    self.showAlert(title: "고정메모는\n최대 \(MemoPin.MaximumNumber)개까지 가능합니다.", okText: "확인", cancelNeeded: false, completionHandler: nil)
                    
                    return
                } else {
                    let item = self.dataSource.itemIdentifier(for: indexPath)!
                    self.repository.updatePin(item)
                    self.list = self.repository.fetch()
                    self.fetchRealm()
                }
                
            }
            let item = self.dataSource.itemIdentifier(for: indexPath)!
            let pinImage = item.pinnedMemo ? "pin.slash.fill" : "pin.fill"
            pin.image = UIImage(systemName: pinImage)
            pin.backgroundColor = .black
            
            return UISwipeActionsConfiguration(actions: [ pin ])
            
            
        }
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
            let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
                // 삭제하기
                self.showAlert(title: "삭제하시겠습니까?", okText: "네, 삭제합니다.", cancelNeeded: true) { action in
                    let item = self.dataSource.itemIdentifier(for: indexPath)!
                    
                    self.repository.deleteMemo(item)
                    self.fetchRealm()
                }
            }
            delete.image = UIImage(systemName: "trash.fill")
            delete.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [delete])
        
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration =  UICollectionView.CellRegistration<UICollectionViewListCell, Memo>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.textProperties.font = .boldSystemFont(ofSize: 14)
            content.secondaryTextProperties.font = .systemFont(ofSize: 12)
            
            content.text = itemIdentifier.title
            
            let dateString: String = self.dateFormat(for: itemIdentifier.dateCreated).replacingOccurrences(of: "\n", with: "")
            
            var contentString = ""
            
            if let content = itemIdentifier.content {
                contentString = content.replacingOccurrences(of: "\n", with: "")
            }
            
            content.prefersSideBySideTextAndSecondaryText = false
            content.secondaryText = "\(dateString)  \(contentString)"
            
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.backgroundColor = .systemBackground
            cell.backgroundConfiguration = background
            
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration , for: indexPath, item: itemIdentifier)
            
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        guard let unpinList = unpinList, let pinList = pinList else { return }
        snapshot.appendSections([.pinned])
        snapshot.appendItems(pinList.toArray(), toSection: .pinned)
        snapshot.appendSections([.unpinned])
        snapshot.appendItems(unpinList.toArray(), toSection: .unpinned)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
extension FixListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = WriteViewController()
        vc.delegate = self
        vc.isEditing = false
        vc.editingMode = true
        
        guard let memo = dataSource.itemIdentifier(for: indexPath) else { return }
        vc.updateTextview(memo: memo)
        vc.editingMemo = memo
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FixListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        
        self.query = query
        filterResult = repository.fetchFilter(query)
        
        guard let filterResult = filterResult else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.search])
        snapshot.appendItems(filterResult.toArray(), toSection: .search)
        dataSource.apply(snapshot)
    }
}

extension FixListViewController: MemoDelegate {
    func updateAllMemo(title: String, content: String?, dateCreated: Date, objectID: ObjectId ) {
        self.repository.updateMemo2(title: title, content: content, dateCreated: dateCreated, _id: objectID)
    }
    func updateSingleMemo(memo: Memo) {
        self.repository.updateMemo(memo)
    }
}


