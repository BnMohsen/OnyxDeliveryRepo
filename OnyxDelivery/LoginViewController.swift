
import Foundation
import UIKit

class LoginViewController: UIViewController {

    let theURL: String = "https://mdev.yemensoft.net:473/"
    //Textfields
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!

    //Login Button
    @IBAction func LoginAction(_ sender: Any) {
        
        let chooseLanguageViewController = self.storyboard?.instantiateViewController(withIdentifier: "choose_language_vc_id")

//        self.present(chooseLanguageViewController!, animated: true, completion: {
//            
//        })
        //self.navigationController?.pushViewController(chooseLanguageViewController!, animated: true)
        login_now(username: Username.text!, password: Password.text!)

    }
    
    func login_now(username:String, password:String) {
        let post_data: NSDictionary = NSMutableDictionary()

        post_data.setValue(username, forKey: "P_DLVRY_NO")
        post_data.setValue(password, forKey: "P_PSSWRD")
        post_data.setValue("2", forKey: "P_LANG_NO")

        let url:URL = URL(string: theURL + "OnyxDeliveryService/Service.svc/CheckDeliveryLogin")!
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
            if let traceID = server_response["traceId"] as? String {
                    
                print(traceID)
                
                DispatchQueue.main.async { [weak self] in
                     
                    
                    let chooseLanguageViewController = self?.storyboard?.instantiateViewController(withIdentifier: "choose_language_vc_id")
                    self?.navigationController?.pushViewController(chooseLanguageViewController!, animated: true)
                }

                
                
                

            }
        }
        )

        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Username.text = "1010"
        Password.text = "1"
    }


    
}
