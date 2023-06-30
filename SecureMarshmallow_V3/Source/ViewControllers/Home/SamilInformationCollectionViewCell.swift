import UIKit
import SnapKit
import Then

class SamilInformationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SamilInformationCollectionViewCell"
    
    private var cellImage: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView: UIImageView = {
        let images = UIImageView()
        images.image = UIImage(named: "3Dlock")
       
        return images
    }()
    
    public func setup() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 25.0
    }
    
    public func layout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(50.0)
        }
    }
    
    func setImage(image: UIImage?) {
        self.imageView.image = image
    }
}
