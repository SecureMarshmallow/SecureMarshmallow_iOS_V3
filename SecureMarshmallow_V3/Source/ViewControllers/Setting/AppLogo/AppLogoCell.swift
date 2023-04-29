import UIKit
import SnapKit
import Then

class AppLogoCell: UICollectionViewCell {
    
    static var identifier = "AppLogoCell"
    
    var appLogoView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(appLogoView)
        
        appLogoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
