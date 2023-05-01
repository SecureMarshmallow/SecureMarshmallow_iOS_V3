import UIKit
import SnapKit
import Then

class DevelopersTableViewCell: UITableViewCell {
    
    lazy var userImage = UIImageView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 25.0
    }
    
    lazy var nameLabel = UILabel().then {
        $0.textColor = .black
        $0.text = ""
        $0.font = .systemFont(ofSize: 15.0, weight: .thin)
    }
    
    lazy var explanationLabel = UILabel().then {
        $0.textColor = .gray
        $0.text = ""
        $0.font = .systemFont(ofSize: 13.0, weight: .thin)
    }
    
    lazy var detailButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = UIColor.black
        $0.isUserInteractionEnabled = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        contentView.addSubview(userImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(explanationLabel)
        contentView.addSubview(detailButton)
        
        userImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24.0)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(detailButton).offset(-24)
            $0.height.equalTo(45.0)
            $0.width.equalTo(35.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.top).offset(5.0)
            $0.leading.equalTo(userImage.snp.trailing).offset(10.0)
        }
        
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        
        detailButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        detailButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
