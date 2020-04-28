import UIKit
import CoreData

class BrunchSpotListTableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting our delegate
        BrunchSpotController.shared.fetchedResultController.delegate = self
    }
    
    // MARK: _@Helper Methods
    func presentAddBrunchSpotAlert() {
        // Adding our controller
        let alertController = UIAlertController(title: "Add a Brunch Spot", message: "Just aiight", preferredStyle: .alert)
        // Adding our textField to our alert
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Whats your Brunch Spots Name?"
        }
        
        // Adding our Add button
        let addBrunchSpotAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text else { return }
            BrunchSpotController.shared.create(brunchSpotName: name)
        }
        // Adding our cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addBrunchSpotAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
    
    // MARK: _@IBAction
    @IBAction func addBrunchSpotBtnTapped(_ sender: Any) {
        presentAddBrunchSpotAlert()
    }
    
    // MARK: - Table view data source
    /**©------------------------------------------------------------------------------©*/
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        BrunchSpotController.shared.fetchedResultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // numberOfObjects:--? Or rows
        BrunchSpotController.shared.fetchedResultController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // We want to use our custom cell. Not the table view cell. So we need to cast as our custom UITableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "brunchSpotCell", for: indexPath)
            as? BrunchSpotTableViewCell else { return UITableViewCell() }
        
        // Data to display. You need to know the data that matches that cell to display it correctly
        let brunchSpot = BrunchSpotController.shared.fetchedResultController.object(at: indexPath)//<--Argument in the func
        cell.updateViews(withBrunchSpot: brunchSpot)
        
        // We need two different files to interact with each other. So we will use our delegate
        cell.delegate = self
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS

// Conformig to the protocol
extension BrunchSpotListTableVC: BrunchSpotTableViewCellDelegate {
    
    func brunchSpotTierUpdated(_ sender: BrunchSpotTableViewCell) {
        // Update the model
        // Update the cell
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        
        let brunchSpot = BrunchSpotController.shared.fetchedResultController.object(at: indexPath)
        // Switching the tier
        var tier = ""
        
        switch sender.brunchTierSegmentControl.selectedSegmentIndex {
            case 0: tier = "S"
            case 1: tier = "A"
            case 2: tier = "Meh"
            default: tier = "Unrated"
        }
        
        BrunchSpotController.shared.changeTier(for: brunchSpot, with: tier)
        // Update the cell
        sender.updateViews(withBrunchSpot: brunchSpot)
    }
}
// A delegate protocol that describes the methods that will be called by the
// associated fetched results controller when the fetch results have changed.

extension BrunchSpotListTableVC: NSFetchedResultsControllerDelegate {
    // Conform to the NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    //sets behavior for cells
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type{
            case .delete:
                guard let indexPath = indexPath else { break }
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .insert:
                guard let newIndexPath = newIndexPath else { break }
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .move:
                guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
                tableView.moveRow(at: indexPath, to: newIndexPath)
                tableView.reloadData()
            case .update:
                guard let indexPath = indexPath else { break }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                fatalError()
        }
    }
    
    //additional behavior for cells
    // Triggers when you change a cells information
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
            case .insert: tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete: tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            case .move: break
            case .update: break
            @unknown default: fatalError()
        }
    }
    
}
