import UIKit

class SettingsCell: BaseSC<SettingsItem> {
    
    static let reuseIdentifier = "SettingsCell"

    override func configure(with item: SettingsItem) {
        super.configure(with: item)
        
        iconImageView.image = item.type.icon
        titleLabel.text = item.type.title
        switchControl.isOn = item.switchState
        switchControl.isHidden = !item.hasSwitch
    }
}
