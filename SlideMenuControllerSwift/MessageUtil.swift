//
//  MessageUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 30..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class MessageUtil: NSObject {
    static let sharedInstance = MessageUtil()
    
    let baseURL = "https://bonodom.com/api/"
    
    func getMessageList(onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        let route = baseURL + "get_messages"
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    //get_messagebyestate
    func getMessageListForEstate(hash: String, uid: Int, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        let hsh = [ "hash", hash]
        let hsh_post = hsh.joinWithSeparator("=")
        
        var id = ["uid", ""]
        if (uid != 0) {
            id = [ "uid", String(uid)]
        }
        
        let id_post = id.joinWithSeparator("=")
        
        let pa = [ tokenpost, hsh_post, id_post]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "get_messagebyestate"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func sendMessage(hash: String, msg: String, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        let hsh = [ "hash", hash]
        let hsh_post = hsh.joinWithSeparator("=")
        
        let message = ["msg", msg]
        let message_post = message.joinWithSeparator("=")
        
        let pa = [ tokenpost, hsh_post, message_post]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "send_message"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    //get_messagecount
    func getMessagecount(hash: String, msg: String, onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        let route = baseURL + "get_messagecount"
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    private func makeHTTPPostRequest(path: String, body: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        //request.addValue("608f44981dd5241547605947c1dc38e0", forHTTPHeaderField: "token");
        
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