import UIKit
import SnapKit
import Then

class MiddleAlamCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MiddleAlamCollectionViewCell"
    
    var imageView = UIImageView().then {
        $0.image = UIImage(named: "")
        $0.backgroundColor = .blue
    }
    
    public func layout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.center.centerY.equalToSuperview()
            $0.height.width.equalTo(150)
        }
    }
}
