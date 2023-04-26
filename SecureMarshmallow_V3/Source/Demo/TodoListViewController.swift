//
//  TodoListViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/26.
//

import UIKit
import CoreData
import SnapKit

@objc(Task)
class Task: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var isCompleted: Bool

}

class TodoListViewController: UIViewController {

    var tableView: UITableView!
    var addButton: UIButton!
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Todo List"
        view.backgroundColor = .white

        setupTableView()
        setupAddButton()

        tasks = loadTasks()
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: "TodoListTableViewCell")
    }

    func setupAddButton() {
        addButton = UIButton(type: .system)
        addButton.setTitle("Add Task", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)

        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.centerX.equalToSuperview()
        }
    }

    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Task Title"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                self.addTask(title: taskTitle)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    func addTask(title: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Task(context: context)
        task.title = title
        task.isCompleted = false
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        tasks.append(task)
        tableView.reloadData()
    }

    func loadTasks() -> [Task] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyModule")
        do {
            let tasks = try context.fetch(fetchRequest) as! [Task]
            return tasks
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

    func updateTask(task: Task) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        tableView.reloadData()
    }

    func deleteTask(task: Task) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(task)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
            tableView.reloadData()
        }
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as! TodoListTableViewCell
        let task = tasks[indexPath.row]
        cell.titleLabel.text = task.title
        cell.isCompletedSwitch.isOn = task.isCompleted
        cell.onSwitchToggle = { [weak self] isOn in
            guard let self = self else { return }
            task.isCompleted = isOn
            self.updateTask(task: task)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        let alertController = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Task Title"
            textField.text = task.title
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                task.title = taskTitle
                self.updateTask(task: task)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = tasks[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else { return }
            self.deleteTask(task: task)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
