import UIKit
import SnapKit
import Then

class ImageFileCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "ImageFileCollectionViewCell"
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.text = "안녕"
        $0.font = .systemFont(ofSize: 20.0, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews([
            imageView,
            titleLabel
        ])
        
        imageView.layer.cornerRadius = 10
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
