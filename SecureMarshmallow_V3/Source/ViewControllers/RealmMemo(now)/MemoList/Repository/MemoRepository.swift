//
//  MemoRepository.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/08.
//

import Foundation
import RealmSwift

protocol MemoRepositoryType {
    func fetch() -> Results<Memo> //최신순 정렬
    func fetchPinnedMemo(_ bool: Bool) -> Results<Memo>
    func fetchFilter(_ query: String) -> Results<Memo>
    func createMemo(_ item: Memo)
    func updateMemo(_ item: Memo)
    func updateMemo2(title: String, content: String?, dateCreated: Date, _id: ObjectId)
    func deleteMemo(_ item: Memo)
    func updatePin(_ item: Memo)
}

class MemoRepository: MemoRepositoryType {
    let localRealm = try! Realm()
    
    func fetch() -> Results<Memo> {
        return localRealm.objects(Memo.self).sorted(byKeyPath: "dateCreated", ascending: false)
    }
    
    func fetchPinnedMemo(_ bool: Bool) -> Results<Memo> {
        return localRealm.objects(Memo.self).filter("pinnedMemo == \(bool)").sorted(byKeyPath: "dateCreated", ascending: false)
    }
    
    func fetchFilter(_ query: String) -> Results<Memo> {
        let tasks = localRealm.objects(Memo.self)
        let results = tasks.where {
            $0.title.contains(query, options: .caseInsensitive) || $0.content.contains(query, options: .caseInsensitive)
        }
        
        return results
    }
    
    func createMemo(_ item: Memo) {
        do {
            try localRealm.write  {
                localRealm.add(item)
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateMemo(_ item: Memo) {
        do {
            try self.localRealm.write {
                localRealm.add(item, update: .modified)
                
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateMemo2(title: String, content: String?, dateCreated: Date, _id: ObjectId) {
        let tasks = localRealm.objects(Memo.self)
        if let result = tasks.where({ $0._id == _id }).first {
            
            do {
                try localRealm.write {
                    result.title = title
                    result.content = content
                    result.dateCreated = dateCreated
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    func deleteMemo(_ item: Memo) {
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
    
    func updatePin(_ item: Memo) {
        do {
            try self.localRealm.write {
                item.pinnedMemo.toggle()
            }
            
        } catch let error {
            print(error)
        }
    }
}
