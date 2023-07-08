import UIKit
import SnapKit
import Then

class ImageCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "ImageCollectionViewCell"
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 10
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
