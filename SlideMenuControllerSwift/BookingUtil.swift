//
//  BookingUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 15..
//  Copyright © 2016. Itechline. All rights reserved.
//

import Foundation
import SwiftyJSON

class BookingUtil: NSObject  {
    static let sharedInstance = BookingUtil()
    
    let baseURL = "https://bonodom.com/api/"
    
    func get_idoponts(id: Int, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let id_post = "ingatlan_id=" + String(id)
        
        let pa = [ tokenpost, id_post]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "get_idopont_dates"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    func get_idoponts_by_user(onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        let route = baseURL + "get_idopont_by_user"
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func get_idoponts_by_datum(id: Int, datum: String, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let datum_post = "datum=" + datum
        let id_post = "ingatlan_id=" + String(id)
        
        
        print ("IDOPONT DATUM", datum)
        print ("IDOPONT INGATLAN ID", String(id))
        
        
        let pa = [ tokenpost, datum_post, id_post]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "get_idopont_by_date"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            print ("IDOPONT ERROR", json)
            onCompletion(json as JSON)
        })
    }
    
    func update_idopont(id: Int, status: Int, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let id_post = "id=" + String(id)
        let status_post = "s=" + String(status)
        
        let pa = [ tokenpost, id_post, status_post]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "update_idopont"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func get_idpontcount(onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        let route = baseURL + "get_idpontcount"
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    //add_idopont
    func add_idopont(mikor: String, ingatlan_id: Int, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let mikor_post = "mikor=" + mikor
        let id_post = "ingatlan_id=" + String(ingatlan_id)
        
        let pa = [ tokenpost, mikor_post, id_post]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "add_idopont"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    private func makeHTTPPostRequest(path: String, body: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
        do {
            print(body)
            let postData:NSData = body.dataUsingEncoding(NSUTF8StringEncoding)!
            
            request.HTTPBody = postData
            
            
            
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error)
                }
            })
            task.resume()
        } catch {
            // Create your personal error
            onCompletion(nil, nil)
        }
    }
}