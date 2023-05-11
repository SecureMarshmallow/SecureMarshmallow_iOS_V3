import UIKit

import RxSwift
import RxCocoa
import RxRelay
import RxFlow

import Then
import SnapKit

import Alamofire
import Kingfisher

class BaseVC: UIViewController {
    let bound = UIScreen.main.bounds
    
    var disposeBag = DisposeBag()
    
    override func viewDidLayoutSubviews() { self.layout() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.bind()
        self.configureUI()
        self.configureItem()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.attribute()
        self.touchEvent()
    }
    
    func touchEvent() { }
    func configureItem() { }
    func bind() { }
    func layout() { }
    func attribute() { }
    func configureUI() { }
    func configureTableView() { }
}
