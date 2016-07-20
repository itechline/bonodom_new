//
//  SpinnerUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 14..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class SpinnerUtil: NSObject {
    static let sharedInstance = SpinnerUtil()
    
    
    let baseURL = "https://bonodom.com/api/"
    
    func get_list_hirdetestipusa(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_hirdetestipusa"
        makeHTTPGetRequest(route, onCompletion: { json, err in
         onCompletion(json as JSON)
         })
    }
    
    func get_list_ingatlanallapota(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_ingatlanallapota"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func get_list_ingatlanenergia(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_ingatlanenergia"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }

    func get_list_ingatlanfutes(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_ingatlanfutes"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func get_list_ingatlankilatas(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_ingatlankilatas"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func get_list_ingatlanparkolas(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_ingatlanparkolas"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func get_list_ingatlanszoba(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_ingatlanszoba"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func get_list_ingatlantipus(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_ingatlantipus"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func get_list_ingatlanemelet(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_ingatlanemelet"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    //list_statuses
    func get_list_statuses(onCompletion: (JSON) -> Void) {
        let route = baseURL + "list_statuses"
        makeHTTPGetRequest(route, onCompletion: { json, err in
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
}
