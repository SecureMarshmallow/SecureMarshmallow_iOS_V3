import UIKit

protocol PasswordWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
    func close()
    func setupViews()
    func presentToSearchBookViewController()
    func updateViews(title: String, imageURL: URL?)
}

final class PasswordWritePresenter {
    private let viewController: PasswordWriteProtocol
    
    private let userDefaultsManager = UserDefaultsManager()
    
    private var passwords: Passwords?
    
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
    
    func didTapRightBarButton(contentsText: String) {
        
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
        
        guard let password = passwords,
              contentsText != contentsTextViewPlaceHolderText
        else { return }
        
        let savePassword = SavePassword(
            title: password.title,
            contents: contentsText
        )
        
        CoreDataManager.shared.saveTask(title: savePassword.title, details: savePassword.contents)
        
        viewController.close()
    }
    
    func didTapTitleButton() {
        viewController.presentToSearchBookViewController()
    }
}
