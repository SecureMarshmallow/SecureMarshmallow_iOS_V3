import UIKit

protocol PasswordWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
    func close()
    func setupViews()
    func presentToSearchBookViewController()
}

final class PasswordWritePresenter {
    private let viewController: PasswordWriteProtocol
    
    private let userDefaultsManager = UserDefaultsManager()
        
    let contentsTextViewPlaceHolderText = "내용을 입력해주세요. "
    
    init(viewController: PasswordWriteProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton(title: String, contentsText: String) {
        
//        guard let passworrdd = passwords,
//              contentsText != contentsTextViewPlaceHolderText
//        else { return }
//
//        let bookReview = SavePassword(
//            title: passworrdd.title,
//            contents: contentsText
//        )
//
//        userDefaultsManager.setReview(bookReview)
//
        
        let savePassword = SavePassword(
            title: title,
            contents: contentsText
        )
        
        CoreDataManager.shared.saveTask(title: savePassword.title, details: savePassword.contents)
        
        viewController.close()
    }
    
    func didTapTitleButton() {
        viewController.presentToSearchBookViewController()
    }
}
