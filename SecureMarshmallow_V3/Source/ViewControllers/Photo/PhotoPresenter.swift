import UIKit

protocol ImageCollectionPresenter {
    func viewDidLoad()
    func deleteSelectedImages()
    func moveImage(from sourceIndex: Int, to destinationIndex: Int)
    func didSelectImage(at index: Int)
    func didDeselectImage(at index: Int)
    func numberOfImages() -> Int
    func image(at index: Int) -> UIImage
    func addImage(_ image: UIImage)
    func reloadData()
    func addImage()
}

class ImageCollectionPresenterImpl: ImageCollectionPresenter {
    weak var view: ImageCollectionView?
    var model: ImageCollection

    init(view: ImageCollectionView) {
        self.view = view
        self.model = ImageCollection(images: [])
    }

    func viewDidLoad() {
        view?.reloadData()
    }

    func addImage() {
        view?.showImagePicker()
    }
    
    func addImage(_ image: UIImage) {
        model.images.append(image)
    }

    func reloadData() {
        view?.reloadData()
    }

    func deleteSelectedImages() {
//        let selectedIndexes = model.images.indices.filter { /* 해당 이미지가 선택된 상태인지 확인 */ }
//        model.images.remove(at: selectedIndexes)
        view?.reloadData()
    }

    func moveImage(from sourceIndex: Int, to destinationIndex: Int) {
        let image = model.images.remove(at: sourceIndex)
        model.images.insert(image, at: destinationIndex)
    }

    func didSelectImage(at index: Int) {
        // 이미지 선택 처리
    }

    func didDeselectImage(at index: Int) {
        // 이미지 선택 해제 처리
    }

    func numberOfImages() -> Int {
        return model.images.count
    }

    func image(at index: Int) -> UIImage {
        return model.images[index]
    }
}
