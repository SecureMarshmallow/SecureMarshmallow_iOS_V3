import Foundation
import UIKit

extension UIViewController {

    public func showAlert(title: String, okText: String, cancelNeeded: Bool, completionHandler: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: okText, style: .destructive, handler: completionHandler)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        if cancelNeeded {
            alert.addAction(cancel)
        }
        self.present(alert, animated: true)
    }

    func memoCountFormat(for number: Int) -> String {
        let countFormat = NumberFormatter()
        countFormat.numberStyle = .decimal
        return countFormat.string(for: number)!
    }

    func dateFormat(for date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
                
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateFormat = "a hh:mm"
        }// 오늘
//        } else if date.isInThisWeek() {
//            dateFormatter.dateFormat = "EEEE"
         else {
            dateFormatter.dateFormat = "yyyy. MM. dd a hh:mm"
        }

        return dateFormatter.string(from: date)
    }
}
