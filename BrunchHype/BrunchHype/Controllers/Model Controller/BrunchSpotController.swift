import Foundation
import CoreData

class BrunchSpotController {

    // MARK: _Shared instance
    let shared = BrunchSpotController()
    
    // MARK: _Getting data from the persistence store/loading the data
    // You need to fetch the result to fetch the data from the PC
    let fetchedResultController: NSFetchedResultsController<BrunchSpot>
    
    // The fetchResultController needs to be initialized
    init() {
        // Creating a fetch request
        let request: NSFetchRequest<BrunchSpot> = BrunchSpot.fetchRequest()
        
        // Telling core data how we want that data to be sorted when it returns to us:--> Array[]
        request.sortDescriptors = [
            NSSortDescriptor(key: "tier", ascending: true),// The data will be sorted by the 'tier'
            NSSortDescriptor(key: "name", ascending: true)// Then the 'name'
        ]
        
        // sectionNameKeyPath :--? The key path on the fetched objects used to determine the section they belong to.
        let resultController: NSFetchedResultsController<BrunchSpot> =
            NSFetchedResultsController(fetchRequest: request,
                                       managedObjectContext: CoreDataStack.context,
                                       sectionNameKeyPath: "tier", cacheName: nil)
        
        // We set our fetchedResultController to our resultController
        fetchedResultController = resultController
        // Nothing in our init will work if we dont perform fetch the data
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("[ERROR] performing the [FETCH]--> \(error.localizedDescription)")
        }
    }
    
    /**©------------------------------------------------------------------------------©*/
    // MARK: _CRUD
    
    // CREATE Add method signatures
    func create(brunchSpotName name: String) {
        BrunchSpot(name: name)
        // Add the object to your of truth
        // which is the persistence store
        saveToPersistence()
    }
    
    /// READ() if we have data to read
    // UPDATE Add method signatures
    func update(brunchSpotObj brunchSpot: BrunchSpot, name: String, tier: String, summary: String) {
        brunchSpot.name = name
        brunchSpot.tier = tier
        brunchSpot.summary = summary
        
        saveToPersistence()
    }
    
    // DELETE Add method signatures
    func delete(brunchSpotObj brunchSpot: BrunchSpot) {
        // You need to remove the object from your source of truth
        // You access it through your shared static instance singleton
        // from our MOC Use your subclassed NSManagedObject
        CoreDataStack.context.delete(brunchSpot)
        saveToPersistence()
    }
    
    // Save to persistence
    func saveToPersistence() {
        // When we save an object, it is saved in our persistence store
        do {// To try to catch any [ERRORS]
            try CoreDataStack.context.save()
        } catch {
            print("[ERROR] saving [Managed Object Context], " +
                  "item not [SAVED]--> \(error.localizedDescription)")
        }
    }
    /**©------------------------------------------------------------------------------©*/
} // End of class
