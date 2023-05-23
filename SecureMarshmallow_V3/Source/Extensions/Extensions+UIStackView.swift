import UIKit

extension UIStackView {
    func addArrangedSubviews(_ viewsToAdd: [UIView]) {
        viewsToAdd.forEach({addArrangedSubview($0)})
    }
}

