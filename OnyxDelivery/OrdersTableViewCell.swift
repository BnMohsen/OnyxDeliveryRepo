
import UIKit

class OrdersTableViewCell: UITableViewCell {
    @IBOutlet var containerView:UIView!
    @IBOutlet var orderNumberLbl:UILabel!
    @IBOutlet var statusLbl:UILabel!
    @IBOutlet var totalPriceLbl:UILabel!
    @IBOutlet var dateLbl:UILabel!
    @IBOutlet var orderDetailsLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 2.0
    }
    
}