import UIKit
import SnapKit
import Then

protocol FileProtocol: AnyObject {
    func navigationSetup()
}

class FilePresenter: NSObject {
    private let viewController: FileProtocol
    private let navigationController: UINavigationController
    
    init(viewController: FileProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func updateWiths() {
        viewController.navigationSetup()
    }
}

extension FilePresenter: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplanationCollectionViewCell.identifier, for: indexPath) as? ExplanationCollectionViewCell
        
        cell?.layer.cornerRadius = 20.0
        cell?.backgroundColor = .cellColor
        cell?.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell?.layer.shadowOpacity = 0.1
        
        if indexPath.row == 0 {
            if let appDataSize = getAppDataSize() {
                let formattedSize = ByteCountFormatter.string(fromByteCount: Int64(appDataSize), countStyle: .file)
                print("앱 내부 데이터 크기: \(formattedSize)")
                cell?.descriptionLabel.text = "\(formattedSize)"
            } else {
                print("앱 내부 데이터 크기를 가져올 수 없습니다.")
            }
            
            cell?.titleLabel.text = "앱 내부 데이터 크기"
        }
        
        if indexPath.row == 1 {
            
            if let totalCapacity = deviceTotalCapacity() {
                let formattedSize = ByteCountFormatter.string(fromByteCount: Int64(totalCapacity), countStyle: .file)
                print("기기의 전체 디스크 용량: \(formattedSize)")
                cell?.descriptionLabel.text = "\(formattedSize)"
            } else {
                print("기기의 전체 디스크 용량을 가져올 수 없습니다.")
            }
            
            cell?.titleLabel.text = "기기의 전체 디스크 용량"
            
        }
        
        if indexPath.row == 2 {
            
            if let availableCapacity = deviceAvailableCapacity() {
                let formattedSize = ByteCountFormatter.string(fromByteCount: Int64(availableCapacity), countStyle: .file)
                print("기기의 사용 가능한 디스크 용량: \(formattedSize)")
                cell?.descriptionLabel.text = "\(formattedSize)"

            } else {
                print("기기의 사용 가능한 디스크 용량을 가져올 수 없습니다.")
            }
            
            cell?.titleLabel.text = "사용 가능한 디스크 용량"
        }
        
        cell?.layout()
        
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension FilePresenter {
    func getAppDataSize() -> UInt64? {
        let documentsDirectory = applicationDocumentsDirectory()
        return sizeOfDirectory(documentsDirectory)
    }
    
    func applicationDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func sizeOfDirectory(_ directory: URL) -> UInt64? {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: directory.path)
            var fileSize: UInt64 = 0
            for file in files {
                let path = directory.appendingPathComponent(file)
                let fileAttributes = try FileManager.default.attributesOfItem(atPath: path.path)
                fileSize += fileAttributes[FileAttributeKey.size] as? UInt64 ?? 0
            }
            return fileSize
        } catch {
            return nil
        }
    }

    func deviceTotalCapacity() -> UInt64? {
        if let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            return attributes[.systemSize] as? UInt64
        }
        return nil
    }

    func deviceAvailableCapacity() -> UInt64? {
        if let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            return attributes[.systemFreeSize] as? UInt64
        }
        return nil
    }
}
