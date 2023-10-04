import UIKit
import Then
import SnapKit

class FixListView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.backgroundColor = .clear
    }


    override func setupUI() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
