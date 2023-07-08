import UIKit
import SnapKit
import Then

class CalendarPickerHeaderView: UIView {
    lazy var monthLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 26, weight: .bold)
        $0.text = "Month"
        $0.accessibilityTraits = .header
        $0.isAccessibilityElement = true
    }
    
    lazy var closeButton = UIButton().then {
        
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: configuration)
        $0.setImage(image, for: .normal)
        
        $0.tintColor = .secondaryLabel
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = true
        $0.isAccessibilityElement = true
        $0.accessibilityLabel = "Close Picker"
    }
    
    lazy var dayOfWeekStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }
    
    lazy var separatorView = UIView().then {
        $0.backgroundColor = UIColor.label.withAlphaComponent(0.2)
    }
    
    private lazy var dateFormatter = DateFormatter().then {
        $0.calendar = Calendar(identifier: .gregorian)
        $0.locale = Locale.autoupdatingCurrent
        $0.setLocalizedDateFormatFromTemplate("MMMM y")
    }
    
    var baseDate = Date() {
        didSet {
            monthLabel.text = dateFormatter.string(from: baseDate)
        }
    }
    
    var exitButtonTappedCompletionHandler: (() -> Void)
    
    init(exitButtonTappedCompletionHandler: @escaping (() -> Void)) {
        self.exitButtonTappedCompletionHandler = exitButtonTappedCompletionHandler
        
        super.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemGroupedBackground
        
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        layer.cornerCurve = .continuous
        layer.cornerRadius = 15
        
        addSubview(monthLabel)
        addSubview(closeButton)
        addSubview(dayOfWeekStackView)
        addSubview(separatorView)
        
        for dayNumber in 1...7 {
            let dayLabel = UILabel()
            dayLabel.font = .systemFont(ofSize: 12, weight: .bold)
            dayLabel.textColor = .secondaryLabel
            dayLabel.textAlignment = .center
            dayLabel.text = dayOfWeekLetter(for: dayNumber)
            
            dayLabel.isAccessibilityElement = false
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
        
        closeButton.addTarget(self, action: #selector(didTapExitButton), for: .touchUpInside)
    }
    
    @objc func didTapExitButton() {
        exitButtonTappedCompletionHandler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dayOfWeekLetter(for dayNumber: Int) -> String {
        switch dayNumber {
        case 1:
            return "S"
        case 2:
            return "M"
        case 3:
            return "T"
        case 4:
            return "W"
        case 5:
            return "T"
        case 6:
            return "F"
        case 7:
            return "S"
        default:
            return ""
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            monthLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: 5),
            
            closeButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 28),
            closeButton.widthAnchor.constraint(equalToConstant: 28),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            dayOfWeekStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayOfWeekStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayOfWeekStackView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -5),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
