import UIKit
import SnapKit
import Foundation
import CryptoKit

class HMACViewController: UICollectionViewCell {
    
    static let identifier = "HMACViewController"
    
    private let originalMessage = "This is the original message."
    
    private let titleLabel = UILabel().then {
        $0.text = "HMAC"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    private let stateImageView = UIImageView()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }
    
    public func setupImageView(_ image: UIImage) {
        stateImageView.image = image
    }
    
    public func resultLabelTextColor(_ color: UIColor) {
        resultLabel.textColor = color
    }
    
    private func setupCell() {
        
        contentView.layer.cornerRadius = 20.0
        
        contentView.backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-0)
        }
        
        addSubview(stateImageView)
        stateImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(-5)
            $0.leading.equalTo(contentView.snp.leading).offset(30)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-30)
            $0.height.equalTo(120.0)
        }
        
        addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(stateImageView.snp.bottom).offset(5.0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).inset(10.0)
        }
    }
    
    func verifyMessage(isTampered: Bool, hmac: HMAC<SHA256>.MAC, secretKey: SymmetricKey) {
        let message = isTampered ? "This is a tampered message." : "This is the original message."
        if isTampered {
            let tamperedHMAC = HMAC<SHA256>.authenticationCode(for: Data(message.utf8), using: secretKey)
            resultLabel.text = HMAC<SHA256>.isValidAuthenticationCode(tamperedHMAC, authenticating: Data(originalMessage.utf8), using: secretKey) ? "변조되지 않았습니다." : "변조 되었습니다."
        } else {
            resultLabel.text = HMAC<SHA256>.isValidAuthenticationCode(hmac, authenticating: Data(message.utf8), using: secretKey) ? "변조되지 않았습니다." : "변조 되었습니다."
        }
    }
}
