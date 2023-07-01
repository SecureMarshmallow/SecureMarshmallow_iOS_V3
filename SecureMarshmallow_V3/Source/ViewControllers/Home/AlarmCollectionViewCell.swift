import UIKit
import Then
import SnapKit

class AlarmCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlarmCollectionViewCell"
    
    var imageView: UIImageView = {
        let images = UIImageView()
        images.image = UIImage(named: "3DTimerImage")
       
        return images
    }()
    
    func layout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(100.0)
        }
    }
}
