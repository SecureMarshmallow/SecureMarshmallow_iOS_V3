//
//  DemoLackCollectionCell.swift
//  Pods
//
//  Created by 박준하 on 2023/04/27.
//

import UIKit

class DemoLackCollectionCell: UICollectionViewCell {
    
    static let cellIdentifier = "DemoLackCollectionCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubviews(titleLabel, detailsLabel)
        setupConstraints()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupLayer() {
        layer.cornerCurve = .continuous
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOffset = CGSize(width: -4, height: 4)
        layer.shadowOpacity = 0.3
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupLayer()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            detailsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        detailsLabel.text = nil
    }
    
    public func configure(with viewModel: LockModel) {
        titleLabel.text = viewModel.title
        detailsLabel.text = viewModel.details
    }
}
