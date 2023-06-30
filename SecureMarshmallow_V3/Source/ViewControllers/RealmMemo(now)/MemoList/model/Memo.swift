import Foundation
import RealmSwift

class Memo: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var content: String?
    @Persisted var dateCreated = Date()
    @Persisted var pinnedMemo: Bool
    
    convenience init(title: String, content: String?, dateCreated: Date ) {
        self.init()
        
        self.title = title
        self.content = content
        self.dateCreated = dateCreated
        self.pinnedMemo = false
    }
}

enum MemoPin {
    static let MaximumNumber = 5
}
