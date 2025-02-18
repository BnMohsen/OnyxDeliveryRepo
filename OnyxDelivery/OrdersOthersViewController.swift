
import UIKit

class OrdersOthersViewController: UITableViewController {
    
    let theURL: String = "https://mdev.yemensoft.net:473/"
    
    var orders = Array<Dictionary<String, Any>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Others"
        
        self.getOrders()
        
        let order1 = ["status": "Returned", "total_price": "6378 LE"]
        orders.append(order1)
        
        let order2 = ["status": "Deliving", "total_price": "540 LE"]
        orders.append(order2)
    }

    
    func getOrders() {
        
        print("get Orders ")
        let post_data: NSDictionary = NSMutableDictionary()

        post_data.setValue("1010", forKey: "P_DLVRY_NO")
        //post_data.setValue(password, forKey: "P_PSSWRD")
        post_data.setValue("2", forKey: "P_LANG_NO")

        let url:URL = URL(string: theURL + "OnyxDeliveryService/Service.svc/GetDeliveryBillsItems")!
        let session = URLSession.shared

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        var paramString = ""

        for  (key, value) in post_data {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }

        request.httpBody = paramString.data(using: String.Encoding.utf8)

        let task = session.dataTask(with: request as URLRequest, completionHandler: {

            data, response, error in

            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                return
            }
            
            print("res 0 " + String(data: data!, encoding: .utf8)!)

            let json: Any?

            do {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch {
                return
            }
            
            print("res 1")
            guard let server_response = json as? NSDictionary else {
                return
            }

            print("res 2")
//            if let traceID = server_response["traceId"] as? String {
//
//                print(traceID)
//
//                DispatchQueue.main.async { [weak self] in
//
//
//                    let chooseLanguageViewController = self?.storyboard?.instantiateViewController(withIdentifier: "choose_language_vc_id")
//                    self?.navigationController?.pushViewController(chooseLanguageViewController!, animated: true)
//                }
//
//            }
        }
        )

        task.resume()
        
        
    }

    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return orders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! OrdersTableViewCell
        
        let order = orders[indexPath.row]
        
        cell.statusLbl?.text = order["status"] as? String
        cell.totalPriceLbl?.text = order["total_price"] as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //self.performSegue(withIdentifier: "newsdetails_vc_segue", sender: self)
        
    }

}
