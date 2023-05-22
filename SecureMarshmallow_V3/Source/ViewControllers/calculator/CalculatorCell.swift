import UIKit
import Then
import SnapKit

class CalculatorCell: UICollectionViewCell {
    static let identifier = "CalculatorCell"
    
    let button = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 30)
//        $0.layer.borderWidth = 0.5
//        $0.layer.borderColor = UIColor.gray.cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
