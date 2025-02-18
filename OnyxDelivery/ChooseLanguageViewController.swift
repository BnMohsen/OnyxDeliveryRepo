
import UIKit

class ChooseLanguageViewController: UIViewController {

    
    //Apply Button
    @IBAction func ApplyAction(_ sender: Any) {
        let ordersTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "orders_tabbar_controller_id")

        self.navigationController?.pushViewController(ordersTabBarController!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }


}