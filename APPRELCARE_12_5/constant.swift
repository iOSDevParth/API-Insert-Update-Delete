

import Foundation
import UIKit
import SystemConfiguration
struct myColors
{
    static let AppThemeColor: UIColor = UIColor.init(colorLiteralRed: 92.0/255.0, green: 226.0/255.0, blue: 237.0/255.0, alpha: 1.0)
    static let LightGrayColor: UIColor = UIColor.init(colorLiteralRed: 47.0/255.0, green: 47.0/255.0, blue: 47.0/255.0, alpha: 1.0)
    static let ButtonSelectionColor: UIColor = UIColor.init(colorLiteralRed: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 0.50)
    
    static let ButtonGreenColor: UIColor = UIColor.init(colorLiteralRed: 0.0/255.0, green: 200.0/255.0, blue: 83.0/255.0, alpha: 0.50)
    static let ButtonRedColor: UIColor = UIColor.init(colorLiteralRed: 229.0/255.0, green: 57.0/255.0, blue: 53.0/255.0, alpha: 0.50)
}

struct Miscellaneous
{
    static let APPDELEGATE  = UIApplication.shared.delegate as! AppDelegate
    
}


extension UIViewController {
    func makeToast(_ toastTitle : String, toastMessage : String) -> Void
    {
        
        var style = ToastStyle()
        style.backgroundColor = UIColor.black
        style.titleColor = myColors.AppThemeColor
        style.titleAlignment = NSTextAlignment.center
        style.messageAlignment = NSTextAlignment.center
        Miscellaneous.APPDELEGATE.window!.makeToast(toastMessage, duration: 2.0, position: .bottom, title: "", image: nil, style: style, completion: nil)
}
    func showMyAlert(myMessage : String) -> Void {
        let alertController = UIAlertController(title: "Warning!", message: myMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

