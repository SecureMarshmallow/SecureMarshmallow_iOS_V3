import UIKit

class ClockCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func layout() {
        switchView.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)

        layer.cornerRadius = 20
        backgroundColor = .cellColor
        layer.borderWidth = 1
    
        addSubviews([
            nameLabel,
            chevronImageView,
            switchView,
        ])

        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.rightAnchor.constraint(equalTo: switchView.leftAnchor),

            chevronImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            switchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchView.rightAnchor.constraint(equalTo: chevronImageView.leftAnchor, constant: -16),
        ])
    }

    func configureWith(_ clock: Clock, capableOfHidden: Bool = false, chevronHidden: Bool = false) {
        nameLabel.text = clock.name
        switchView.isOn = clock.isActivated
        chevronImageView.isHidden = chevronHidden
        
        if (switchView.isOn) {
            layer.borderColor = UIColor.white.cgColor
            nameLabel.textColor = .cellTitleColor
            layer.shadowOffset = CGSize(width: 10, height: 10)
            layer.shadowOpacity = 0.1
        }
        else {
            layer.borderColor = UIColor.black.cgColor
            nameLabel.textColor = .lightGray
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .cellTitleColor
        label.numberOfLines = 0

        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.isHidden = false
        return imageView
    }()
    
    let switchView: UISwitch = {
        let switchDemo = UISwitch()
        switchDemo.translatesAutoresizingMaskIntoConstraints = false
        switchDemo.tintColor = .gray
        switchDemo.onTintColor = .black
        switchDemo.thumbTintColor = .white
        switchDemo.setOn(false, animated: true)
        return switchDemo
    }()
    
    var switchValueChanged: ((Bool) -> ()) = { _ in }

    @objc func switchStateDidChange(_ sender: UISwitch!)
    {
        let defaults = UserDefaults.standard
        
        let key = nameLabel.text
        
        if (sender.isOn == true){
            print("on 🔊")
            defaults.set(true, forKey: key!)
            print(key!)
            nameLabel.textColor = .cellTitleColor
            layer.borderColor = UIColor.white.cgColor
            layer.shadowOffset = CGSize(width: 10, height: 10)
            layer.shadowOpacity = 0.1
        }
        else{
            print("off 🔈")
            defaults.set(false, forKey: key!)
            print(key!)
            nameLabel.textColor = .lightGray
            layer.borderColor = UIColor.clear.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowOpacity = 0
        }
        switchValueChanged(sender.isOn)
    }
}
