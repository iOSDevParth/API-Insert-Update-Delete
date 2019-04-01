

import UIKit
import Foundation

class Global: NSObject
{
    static let sharedInstance = Global()
    
    // Variable Declaration
    var DeviceToken = String()
    var UserID = String()
    
    var myAddress = String()

    var myLatitude = Double()
    var myLongitude = Double()
    
    var myImage = String()

    class func setDeviceToken(DeviceToken : String) -> Void {
        sharedInstance.DeviceToken = DeviceToken
    }
    class func getDeviceToken() -> String {
        return sharedInstance.DeviceToken as String
    }
    
    
    class func setUserID(setUserID : String) -> Void {
        sharedInstance.UserID = setUserID as String
    }
    class func getUserID() -> String {
        return sharedInstance.UserID as String
    }
    
    class func setUserImage(setUserImage : String) -> Void {
        sharedInstance.myImage = setUserImage as String
    }
    class func getUserImage() -> String {
        return sharedInstance.myImage as String
    }
    
}
