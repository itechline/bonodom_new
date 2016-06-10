//
//  SettingUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 09..
//  Copyright © 2016. Itechline. All rights reserved.
//

import Foundation

class SettingUtil: NSObject {
    static let sharedInstance = SettingUtil()


    func getToken() -> String {
        let preferences = NSUserDefaults.standardUserDefaults()
    
        let tokenKey = "token"
    
        if preferences.objectForKey(tokenKey) == nil {
            print ("Token does not exist")
        } else {
            let token = preferences.stringForKey(tokenKey)
            return token!
        }
        return ""
    }
    
    func setToken(token: String) {
        let preferences = NSUserDefaults.standardUserDefaults()
        
        let tokenKey = "token"
        
        //preferences.setValue(token, forUndefinedKey: tokenKey)
        preferences.setObject(token, forKey: tokenKey)
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if !didSave {
            print ("Token cannot be saved")
        }
    }
}