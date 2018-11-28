import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Properties
    
    private let modelName: String
    
    // MARK: - Initialization
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Core Data Stack
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    
    func fetchRecords<T: NSManagedObject>(type: T.Type) -> [T]? {
        
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(type))
        
        do {
            
            let records = try managedObjectContext.fetch(fetchRequest)
            return records
            
        } catch {
            print("Unable to fetch managed objects for entity \(NSStringFromClass(type)).")
            return nil
        }
        
    }
    
    func fetchRecordsByPredicate<T: NSManagedObject>(type: T.Type, predicate: NSPredicate?) -> [T]? {
        
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(type))
        fetchRequest.predicate = predicate
        
        do {
            let records = try managedObjectContext.fetch(fetchRequest)
            return records
        } catch {
            print("Unable to fetch managed objects for entity \(NSStringFromClass(type)).")
            return nil
        }
        
    }
    
    func createRecord<T: NSManagedObject>(type: T.Type) -> T? {
        
        var result: T?
        
        let entityDescription = NSEntityDescription.entity(forEntityName: NSStringFromClass(type), in: managedObjectContext)
        
        if let entityDescription = entityDescription {
            result = T(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return result
    }
}
