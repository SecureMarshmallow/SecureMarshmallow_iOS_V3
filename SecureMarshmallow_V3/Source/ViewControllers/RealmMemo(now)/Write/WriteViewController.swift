import UIKit
import RealmSwift

class WriteViewController: BaseVC {
    
    weak var delegate: MemoDelegate?
    var editingMode: Bool = false
    var editingMemo = Memo()
    let writeView = WriteView()
    let memoRepository = MemoRepository()
    
    override func loadView() {
        self.view = writeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        saveText()
    }

    override func configureUI() {
        if editingMode {
            setBarButton(false)
        } else {
            setBarButton(true)
        }
        writeView.textView.delegate = self
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func updateTextview(memo: Memo) {
        isEditing = false
        
        if let content = memo.content {
            writeView.textView.text = memo.title + content
        } else {
            writeView.textView.text = memo.title
        }
    }
    
    func saveText() {
        guard let text = writeView.textView.text, !text.isEmpty else { return }
        if let index = text.firstIndex(of: "\n"){
            let title = String(text[..<index])
            let content = String(text[index...])
            let item = Memo(title: title, content: content, dateCreated: Date())
            
            if editingMode {
                delegate?.updateAllMemo(title: title, content: content, dateCreated: Date(), objectID: editingMemo._id)
            }
            else {
                memoRepository.createMemo(item)
            }
            
        } else {
            let item = Memo(title: text, content: nil, dateCreated: Date())
            if editingMode {
                delegate?.updateAllMemo(title: text, content: nil, dateCreated: Date(), objectID: editingMemo._id)
            }
            else {
                memoRepository.createMemo(item)
            }
        }
    }
    
    @objc func shareButtonTapped(_ sender: UIBarButtonItem) {
        if let text = writeView.textView.text, !text.isEmpty {
            let viewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            
            viewController.excludedActivityTypes = [ .assignToContact, .postToTencentWeibo, .postToVimeo, .postToFlickr, .saveToCameraRoll]
            
            self.present(viewController, animated: true)
        } else {
            showAlert(title: "공유할 내용이 없습니다.", okText: "확인", cancelNeeded: false, completionHandler: nil)
        }
    }
    
    @objc func completeButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setBarButton(_ bool : Bool) {
        if bool {
            writeView.textView.becomeFirstResponder()
            
            let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
            let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonTapped))
            
            let items = [ completeButton, shareButton ]
            items.forEach { $0.tintColor = .black }
            
            navigationItem.rightBarButtonItems = items
        } else {
            navigationItem.rightBarButtonItems = nil
        }
    }
}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setBarButton(true)
        
    }
}
