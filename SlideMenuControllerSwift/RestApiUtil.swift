//
//  RestApiUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 06..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiUtil: NSObject {
    static let sharedInstance = RestApiUtil()
    
    let baseURL = "https://bonodom.com/api/"
    
    func getTokenValidator(onCompletion: (JSON) -> Void) {
    
        let token = [ "token", "2d1933ceaf3fba2095fe8a4d4995cfc1"]
        let tokenpost = token.joinWithSeparator("=")
        
        let route = baseURL + "token_validator"
        //let listEstateHeader: [String: String] = ["token": "608f44981dd5241547605947c1dc38e0"]
        /*makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })*/
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
            })
        
    }
    
    
    /*
     postadatok.put("ingatlan_id", idPost);
     postadatok.put("page", pagePost);
     postadatok.put("token", tokenTosend);
     postadatok.put("favorites", favorites);
     postadatok.put("etype", etype);
     postadatok.put("ordering", ordering);
     postadatok.put("justme", jstme);
 */
    
    func getEstateList(ingatlan_id: String, page: Int, fav: Int,etype: Int, ordering: Int, justme: Int ,onCompletion: (JSON) -> Void) {
        
        let token = [ "token", "2d1933ceaf3fba2095fe8a4d4995cfc1"]
        let tokenpost = token.joinWithSeparator("=")
        let ingatlan = [ "ingatlan_id", "0"]
        let ingatlanid = ingatlan.joinWithSeparator("=")
        let page = [ "page", "0"]
        let page_send = page.joinWithSeparator("=")
        let fav = [ "favorites", "0" ]
        let fav_send = fav.joinWithSeparator("=")
        let etype = [ "etype", "0"]
        let etype_send = etype.joinWithSeparator("=")
        let ordering = [ "ordering", "0"]
        let ordering_send = ordering.joinWithSeparator("=")
        let justme = [ "justme", "0"]
        let justme_send = justme.joinWithSeparator("=")
        
        
        
        let pa = [ tokenpost, ingatlanid, page_send, fav_send,  etype_send, ordering_send, justme_send]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "list_estates"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
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