//
//  ReviewListPresenter.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/07.
//
import UIKit

protocol ListProtocol{
    func setupNavigationBar()
    func setupViews()
    func presentToWriteViewController()
    func reloadTableView()
}

final class ListPresenter: NSObject {
    private let viewController: ListProtocol
    private let userDefaultManger = UserDefaultsManager()
    
    private let coreDataManager = CoreDataManager.shared

    private var tasks: [Task] = []

    private var review: [SavePassword] = []
    
    init(viewController:
         ListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        tasks = coreDataManager.fetchTasks()
        viewController.reloadTableView()
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        tasks = coreDataManager.fetchTasks()
        review = userDefaultManger.getReviews()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToWriteViewController()
    }
}

extension ListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.details
        
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(task)
            
            do {
                try context.save()
            } catch {
                print("❌ Error saving context: \(error)")
            }
            
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
