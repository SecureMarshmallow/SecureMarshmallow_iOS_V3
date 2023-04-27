//
//  TaskModel.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/27.
//

import Foundation

final class TaskViewModel {
    
    var taskList: [Task] = []
    
    private let coreDataManager = CoreDataManager()
    
    func fetchTaskList() {
        let list = coreDataManager.fetchTasks()
        taskList = list
    }
    
    func saveTask(title: String, details: String?){
        coreDataManager.saveTask(title: title  , details: details)
    }
}
