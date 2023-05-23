import UIKit
import SnapKit
import Then

class SupportCell: BaseSC<SupportItem> {
    
    static var reuseIdentifier = "SupportCell"
    
    override func configure(with item: SupportItem) {
        super.configure(with: item)
        
        titleLabel.text = item.type.title
        switchControl.isOn = item.switchState
        switchControl.isHidden = !item.hasSwitch
    }
}
