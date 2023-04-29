//
//  MarshmallowWidgetViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/29.
//

//import UIKit
//import NotificationCenter
//
//class MarshmallowWidgetViewController: UIViewController, NCWidgetProviding {
//    
//    // 위젯에서 보여줄 이미지
//    let image = UIImage(named: "myImage")
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 이미지 뷰 생성
//        let imageView = UIImageView(frame: view.bounds)
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//
//        // 뷰에 이미지 뷰 추가
//        view.addSubview(imageView)
//    }
//
//    // 위젯 크기 설정
//    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
//        preferredContentSize = maxSize
//    }
//
//    // 위젯 데이터 업데이트
//    func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
//        // 이미지는 고정값으로 설정되어 있으므로 업데이트 필요 없음
//        completionHandler(.noData)
//    }
//}


