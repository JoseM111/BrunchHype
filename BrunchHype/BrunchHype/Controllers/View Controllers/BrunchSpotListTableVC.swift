import UIKit

class BrunchSpotListTableVC: UITableViewController {
    
    // MARK: _@IBOutlet
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: _@IBAction
    @IBAction func addBrunchSpotBtnTapped(_ sender: Any) {
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
        
        // Configure the cell...
        
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
