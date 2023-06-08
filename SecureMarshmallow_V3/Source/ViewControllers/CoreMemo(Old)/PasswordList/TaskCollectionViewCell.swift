//import UIKit
//import SnapKit
//import Then
//
//class MemoCollectionViewCell: UICollectionViewCell {
//    static let reuseIdentifier = "TaskCellIdentifier"
//    
//    public lazy var titleLabel = UILabel().then {
//        $0.textAlignment = .center
//        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        contentView.layer.cornerRadius = 20.0
//        contentView.backgroundColor = .white
//        contentView.addSubview(titleLabel)
//        
//        titleLabel.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.centerY.equalToSuperview()
//        }
//    }
//    
//    func configure(title: String) {
//        titleLabel.text = title
//    }
//}
