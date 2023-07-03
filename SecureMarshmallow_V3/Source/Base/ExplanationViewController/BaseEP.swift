import UIKit
import Then
import SnapKit

class BaseEP: BaseVC {
    
    internal lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 60.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 30.0, bottom: 10.0, right: 30.0)

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .BackGray
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            ExplanationCollectionViewCell.self,
            forCellWithReuseIdentifier: ExplanationCollectionViewCell.identifier
        )

        return collectionView
    }()
    
    internal lazy var customImageView = UIImageView().then {
        $0.image = UIImage(named: "Battery")
    }
    
    internal lazy var backgroundView = UIView().then {
        $0.backgroundColor = .BackGray
    }
    
    internal lazy var nameLabel = UILabel().then {
        $0.text = "이름을 입력해주세요"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 1
        $0.textColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateWith(self)
    }
    
    func updateWith(_ controller: UIViewController) {
        [
            customImageView,
            backgroundView,
            nameLabel,
            collectionView
        ].forEach { view.addSubview($0) }
        
        backgroundView.layer.cornerRadius = 20.0

        customImageView.snp.makeConstraints {
            $0.height.width.equalTo(200.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
        }

        backgroundView.snp.makeConstraints {
            $0.top.equalTo(customImageView.snp.bottom).offset(95.0)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(430.0)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(15.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(ExplanationCollectionViewCell.height * 4)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5.0)
        }
    }
}

extension BaseEP: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplanationCollectionViewCell.identifier, for: indexPath) as? ExplanationCollectionViewCell
        
        cell?.layer.cornerRadius = 20.0
        cell?.backgroundColor = .cellColor
        cell?.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell?.layer.shadowOpacity = 0.1
        
        cell?.layout()
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.width - 60,
            height: ExplanationCollectionViewCell.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
