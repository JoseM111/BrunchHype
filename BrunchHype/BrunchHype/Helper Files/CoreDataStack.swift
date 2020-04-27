import Foundation
import CoreData

class CoreDataStack {

    static let container: NSPersistentContainer = {
        // App name is generated from our Bundle
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        let container = NSPersistentContainer(name: appName)
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    return container
}()
    // Saves you time from writing this multiple times in your app
    static var context: NSManagedObjectContext { return container.viewContext }
}

