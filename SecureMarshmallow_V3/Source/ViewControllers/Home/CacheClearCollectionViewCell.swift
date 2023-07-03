import UIKit
import SnapKit
import Then

class CacheClearCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CacheClearCollectionViewCell"

    let clearCacheImage = UIImageView().then {
        $0.image = UIImage(named: "trashCan")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupClearCacheButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupClearCacheButton() {
        contentView.backgroundColor = .white
        contentView.addSubview(clearCacheImage)
        contentView.layer.cornerRadius = 20.0

        clearCacheImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(100.0)
        }
    }
}
