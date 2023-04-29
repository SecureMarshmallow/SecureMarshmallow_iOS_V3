import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "SecureMarshmallow")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveTask(title: String, details: String?) {
        let task = Task(context: managedObjectContext)
        task.setValue(title, forKey: "title")
        task.setValue(details, forKey: "details")
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func fetchTasks() -> [Task] {
        do {
            let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
            let tasks = try managedObjectContext.fetch(fetchRequest)
            return tasks
        } catch {
            print(error)
            return []
        }
    }
}
