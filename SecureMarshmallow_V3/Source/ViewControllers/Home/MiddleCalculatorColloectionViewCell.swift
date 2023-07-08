import UIKit
import SnapKit
import Then

class MiddleCalculatorColloectionViewCell: UICollectionViewCell {
    
    static let identifier = "MiddleCalculatorColloectionViewCell"
    
    var imageView = UIImageView().then {
        $0.image = UIImage(named: "calculatorImage")
    }
    
    public func layout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.center.centerY.equalToSuperview()
            $0.height.width.equalTo(150)
        }
    }
}
