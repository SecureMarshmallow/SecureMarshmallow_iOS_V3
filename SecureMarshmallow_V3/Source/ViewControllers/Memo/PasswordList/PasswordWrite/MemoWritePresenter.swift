import UIKit

protocol MemoWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
    func close()
    func layout()
    func attribute()
}

final class MemoWritePresenter {
    private let viewController: MemoWriteProtocol
    
    private let userDefaultsManager = UserDefaultsManager()
        
    let contentsTextViewPlaceHolderText = "내용을 입력해주세요. "
    
    init(viewController: MemoWriteProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.layout()
        viewController.attribute()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton(title: String, contentsText: String) {
        
        let savePassword = MemoData(
            title: title,
            contents: contentsText
        )
        
        CoreDataManager.shared.saveTask(title: savePassword.title, details: savePassword.contents)
        
        viewController.close()
    }
}
