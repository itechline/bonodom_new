//
//  LoginUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 08..
//  Copyright © 2016. Itechline. All rights reserved.
//

//
//  RestApiUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 06..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class LoginUtil: NSObject {
    static let sharedInstance = LoginUtil()
    
    let baseURL = "https://bonodom.com/api/"
    
    func getTokenValidator(onCompletion: (JSON) -> Void) {
        
        let token = [ "token", "2d1933ceaf3fba2095fe8a4d4995cfc1"]
        let tokenpost = token.joinWithSeparator("=")
        
        let route = baseURL + "token_validator"
        /*makeHTTPGetRequest(route, onCompletion: { json, err in
         onCompletion(json as JSON)
         })*/
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func doLogin(email: String, password: String, onCompletion: (JSON) -> Void) {
        
        let mail = [ "email", email]
        let mailPost = mail.joinWithSeparator("=")
        let pass = [ "pass", password]
        let passPost = pass.joinWithSeparator("=")
        
        let pa = [ mailPost, passPost]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "do_login"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func doLogout(email: String, password: String, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", "2d1933ceaf3fba2095fe8a4d4995cfc1"]
        let tokenpost = token.joinWithSeparator("=")
        
        let route = baseURL + "do_logout"
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    
    
    
    
    
    
    
    // MARK: Perform a GET Request
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(nil, error)
            }
        })
        task.resume()
    }
    
    // MARK: Perform a POST Request
    private func makeHTTPPostRequest(path: String, body: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        //request.addValue("608f44981dd5241547605947c1dc38e0", forHTTPHeaderField: "token");
        
        do {
            // Set the POST body for the request
            //let jsonBody = try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
            //let asdf = try NSData(body)
            //request.HTTPBody = jsonBody
            //let post:NSString = "token=608f44981dd5241547605947c1dc38e0"
            print(body)
            let postData:NSData = body.dataUsingEncoding(NSASCIIStringEncoding)!
            
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
