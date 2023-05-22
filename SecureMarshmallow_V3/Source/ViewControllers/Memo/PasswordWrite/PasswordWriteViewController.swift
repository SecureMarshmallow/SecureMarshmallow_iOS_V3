import SnapKit
import UIKit

final class ReviewWriteViewController: UIViewController {
    private lazy var presenter = PasswordWritePresenter(viewController: self)
    
    private lazy var titleTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요."
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: 23.0, weight: .bold)
    }
    
    private lazy var contentsTextView = UITextView().then {
        $0.textColor = .tertiaryLabel
        $0.text = presenter.contentsTextViewPlaceHolderText
        $0.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        $0.delegate = self
    }
    
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .secondarySystemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else {
            return
        }
        
        textView.text = nil
        textView.textColor = .label
    }
}

extension ReviewWriteViewController: PasswordWriteProtocol {

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapRightBarButton)
        )
    }
    
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "저장되지 않을 수 있습니다\n 그래도 닫을 겠습니까?", message: nil, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [closeAction, cancelAction].forEach {
            alertController.addAction($0)
        }
        
        present(alertController, animated: true)
    }
    
    func close() {
        dismiss(animated: true)
    }
    
    func layout() {

        [titleTextField, contentsTextView, imageView]
            .forEach { view.addSubview($0) }

        titleTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20.0)
        }

        contentsTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(titleTextField.snp.bottom).offset(16.0)
        }

        imageView.snp.makeConstraints {
            $0.leading.equalTo(contentsTextView.snp.leading)
            $0.trailing.equalTo(contentsTextView.snp.trailing)
            $0.top.equalTo(contentsTextView.snp.bottom).offset(16.0)

            $0.height.equalTo(200.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func attribute() {
        view.backgroundColor = .systemBackground
    }
    
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton(title: titleTextField.text!, contentsText: contentsTextView.text)
    }

}
