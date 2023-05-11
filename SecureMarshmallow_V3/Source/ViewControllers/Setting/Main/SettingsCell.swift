import UIKit

class SettingsCell: BaseSC<SettingsItem> {
    
    static let reuseIdentifier = "SettingsCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let cornerRadius: CGFloat = 10
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer

        // 배경색 적용을 위한 추가 코드
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.insertSublayer(shapeLayer, at: 0)
    }

    override func configure(with item: SettingsItem) {
        super.configure(with: item)
        
        iconImageView.image = item.type.icon
        titleLabel.text = item.type.title
        switchControl.isOn = item.switchState
        switchControl.isHidden = !item.hasSwitch
    }
}
