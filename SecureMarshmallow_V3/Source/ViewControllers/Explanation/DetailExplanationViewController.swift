import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

public class DetailExplanationViewController: UIViewController {
    
    var disposebag = DisposeBag()
    
    var imageView = UIImageView()
    
    var mainTitle = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 40.0, weight: .bold)
    }
    
    var nameTitle = UILabel().then {
        $0.textColor = .black
        $0.text = "정의"
        $0.font = .systemFont(ofSize: 25.0, weight: .bold)
    }
    
    var nameDetailTitle = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
    }
    
    var explanationTitle = UILabel().then {
        $0.textColor = .black
        $0.text = "사용 이유"
        $0.font = .systemFont(ofSize: 25.0, weight: .bold)
    }
    
    // Explanation Detail Title Label
    var explanationDetailTitle = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
    }
    
    // Section divider
    var sectionDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    // ScrollView for scrolling the content
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView = UIView()
    
    public init(mainTitleText: String, explanationTitleText: String, nameDetailTitleText: String, explanationDetailTitleText: String, imageView: UIImage) {
        super.init(nibName: nil, bundle: nil)
        
        // Set the text for each label
        self.mainTitle.text = mainTitleText
        self.nameDetailTitle.text = nameDetailTitleText
        self.explanationTitle.text = explanationTitleText
        self.explanationDetailTitle.text = explanationDetailTitleText
        
        // Set the image for the imageView
        self.imageView.image = imageView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    func layout() {
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(25.0)
            $0.bottom.equalTo(scrollView).offset(-25.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        [
            imageView,
            mainTitle,
            nameTitle,
            nameDetailTitle,
            sectionDivider,
            explanationTitle,
            explanationDetailTitle
        ].forEach { stackView.addArrangedSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200.0)
        }
        
        mainTitle.snp.makeConstraints {
            $0.centerY.equalTo(imageView.snp.bottom)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        nameTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.0)
        }
        
        nameDetailTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        sectionDivider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(stackView).multipliedBy(0.9)
        }
        
        explanationTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.0)
        }
        
        explanationDetailTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }
}
