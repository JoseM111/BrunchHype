import UIKit

/**©-------------------------------------------©*/
protocol BrunchSpotTableViewCellDelegate: class {
    func brunchSpotTierUpdated(_ sender: BrunchSpotTableViewCell)
}

/**©-------------------------------------------©*/

class BrunchSpotTableViewCell: UITableViewCell {
    /**©------------------------------------------------------------------------------©*/
    // MARK: _@IBOutlet
    @IBOutlet weak var brunchSpotNamedLabel: UILabel!
    @IBOutlet weak var brunchTierSegmentControl: UISegmentedControl!
    
    // MARK: _@Delegate weak var delegate
    weak var delegate: BrunchSpotTableViewCellDelegate?
    
    // MARK: _@IBAction
    @IBAction func tierChanged(_ sender: Any) {
        delegate?.brunchSpotTierUpdated(self)
    }
    /**©------------------------------------------------------------------------------©*/
    // Function that updates the information for our cell.
    func updateViews(withBrunchSpot brunchSpot: BrunchSpot) {
        brunchSpotNamedLabel.text = brunchSpot.name
        
        // Will determine which tier it is and select the correct tier
        switch brunchSpot.tier {
            case "S":
                brunchTierSegmentControl.selectedSegmentIndex = 0
                backgroundColor = .cyan
            case "A":
                brunchTierSegmentControl.selectedSegmentIndex = 1
                backgroundColor = .yellow
            case "Meh":
                brunchTierSegmentControl.selectedSegmentIndex = 2
                backgroundColor = .lightGray
            case "Unrated": // Default case in the initializer of BrunchSpot
                // The default value is noSegment (no segment selected)
                // until the user touches a segment. Set this property
                // to -1 to turn off the current selection.
                brunchTierSegmentControl.selectedSegmentIndex = -1
                backgroundColor = .darkGray
            default:
                break
        }
    }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS
