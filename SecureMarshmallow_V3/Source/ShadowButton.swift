import UIKit
import Then

class ShadowButton: UIControl {
    
    private let buttonView = UIView()
    private let shadowView = UIView()
    private let buttonLabel = UILabel()
    
    private var selectedState = false
    
    override var isSelected: Bool {
        didSet {
            buttonView.backgroundColor = selectedState ? .systemBlue : .systemGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        buttonView.layer.cornerRadius = frame.height / 2
        buttonView.clipsToBounds = true
        addSubview(buttonView)
        
        shadowView.layer.cornerRadius = buttonView.layer.cornerRadius
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 4
        addSubview(shadowView)
        
        buttonLabel.textAlignment = .center
        buttonLabel.textColor = .white
        buttonLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        buttonLabel.text = "Button"
        buttonView.addSubview(buttonLabel)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        addGestureRecognizer(gestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttonView.frame = bounds
        shadowView.frame = bounds
        buttonLabel.frame = buttonView.bounds
    }
    
    private func animateButtonView() {
        UIView.animate(withDuration: 0.3) {
            self.buttonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { (_) in
            UIView.animate(withDuration: 0.3) {
                self.buttonView.transform = .identity
            }
        }
    }
    
    @objc private func buttonTapped() {
        selectedState = !selectedState
        isSelected = selectedState
        animateButtonView()
        sendActions(for: .valueChanged)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        animateButtonView()
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        selectedState = !selectedState
        isSelected = selectedState
        sendActions(for: .valueChanged)
    }
}
