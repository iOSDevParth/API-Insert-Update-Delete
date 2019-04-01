
import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class AFWrapper: NSObject {
    
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        if Reachability.isConnectedToNetwork() {        //Check For I/N Connection
           
    
            Miscellaneous.APPDELEGATE.window!.makeToastActivity(.center)   //Activity Indicator
            
            let myURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            Alamofire.request(myURL!).responseJSON { (responseObject) -> Void in
                
                if responseObject.result.isSuccess {
                    
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                                    }
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error)
                }

              Miscellaneous.APPDELEGATE.window!.hideToastActivity()
            }
        }
            
        else {
           Miscellaneous.APPDELEGATE.window!.makeToast("Internet Connection Is Unavailable...", duration: 3.0, position: .bottom)
        }

        
        
    }
    
   
    class func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
       
        if Reachability.isConnectedToNetwork() {        //Check For I/N Connection

        let myURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        Miscellaneous.APPDELEGATE.window!.makeToastActivity(.center)   //Activity Indicator
            Alamofire.request(myURL!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
                
                
                if responseObject.result.isSuccess {
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                }
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error)
                }
                Miscellaneous.APPDELEGATE.window!.hideToastActivity()

            }
        }
        else {
            Miscellaneous.APPDELEGATE.window!.makeToast("Internet Connection Is Unavailable...", duration: 3.0, position: .bottom)
        }
    }
}
