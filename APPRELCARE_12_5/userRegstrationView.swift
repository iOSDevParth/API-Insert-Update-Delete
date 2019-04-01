

import UIKit
import Alamofire
    
class ViewController: userRegstrationView {
        
        var arrHelp = NSMutableArray()
    
        override func viewDidLoad() {
            super.viewDidLoad()
                        // Do any additional setup after loading the view, typically from a nib.
            self.WBGetHelp()
            
        }
        
    //Get Data From API
    
    func WBGetHelp() -> Void {
        let strURL = "http://192.168.0.201/projects/louis/apparel-care/api/?action=user_register"
        print(strURL)
        
        AFWrapper.requestGETURL(strURL, success: {
            (JSONResponse) -> Void in
            
            if let resData = JSONResponse.dictionaryObject {
                
                let status = resData["code"] as! NSNumber
                if status == 1
                {
                    print(resData)
                    if let myArray = resData["data"] as? NSArray {
                        self.arrHelp = myArray.mutableCopy() as! NSMutableArray
                        print(self.arrHelp)
                        
                        
                    }
                }
                else{
                    
                    if let resData = JSONResponse.dictionaryObject {
                        let status = resData["msg"] as! NSString
                        print(status as String)
                    }
                }
            }
            
        }) {
            (error) -> Void in
            print(error)
        }
    }
    
}

