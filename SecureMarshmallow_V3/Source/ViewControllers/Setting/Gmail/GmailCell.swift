import UIKit
import Then
import SnapKit

class GmailCell: BaseSC<GmailItem> {
    
    static let reuseIdentifier = "GmailCell"
    
    override func configure(with item: GmailItem) {
        super.configure(with: item)
        
        titleLabel.text = item.type.title
        switchControl.isOn = item.switchState
        switchControl.isHidden = !item.hasSwitch
    }
    
}
