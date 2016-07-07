//
//  AdMonitorUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 01..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class AdMonitorUtil: NSObject {
    static let sharedInstance = AdMonitorUtil()
    let baseURL = "https://bonodom.com/api/"
    
    
    func add_admonitor(name: String, butor: String, lift: String, erkely: String, meret: String, szsz_max: String, szsz_min: String, emelet_max: String, emelet_min: String, tipus_id: Int, allapot_id: Int, energia_id: Int, kilatas_id: Int, parkolas: Int, ar_min: String, ar_max: String, kulcsszo: String, onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        let name = "name=" + name
        let ingatlan_butorozott = "ingatlan_butorozott=" + butor
        let ingatlan_lift = "ingatlan_lift=" + lift
        let ingatlan_erkely = "ingatlan_erkely=" + erkely
        let ingatlan_meret = "ingatlan_meret=" + meret
        let ingatlan_szsz_max = "ingatlan_szsz_max=" + szsz_max
        let ingatlan_szsz_min = "ingatlan_szsz_min=" + szsz_min
        let ingatlan_emelet_max = "ingatlan_emelet_max=" + emelet_max
        let ingatlan_emelet_min = "ingatlan_emelet_min=" + emelet_min
        let ingatlan_tipus_id = "ingatlan_tipus_id=" + String(tipus_id)
        let ingatlan_allapot_id = "ingatlan_allapot_id=" + String(allapot_id)
        let ingatlan_energiatan_id = "ingatlan_energiatan_id=" + String(energia_id)
        let ingatlan_kilatas_id = "ingatlan_kilatas_id=" + String(kilatas_id)
        let ingatlan_ar_min = "ingatlan_ar_min=" + ar_min
        let ingatlan_ar_max = "ingatlan_ar_max=" + ar_max
        let keyword = "keyword=" + kulcsszo
        let ingatlan_parkolas_id = "ingatlan_parkolas_id=" + String(parkolas)
        
        
        
        let pa = [ tokenpost, name, ingatlan_butorozott, ingatlan_lift, ingatlan_erkely, ingatlan_meret, ingatlan_szsz_max, ingatlan_szsz_min, ingatlan_emelet_max, ingatlan_emelet_min, ingatlan_tipus_id, ingatlan_allapot_id, ingatlan_energiatan_id, ingatlan_kilatas_id, ingatlan_ar_min, ingatlan_ar_max, keyword, ingatlan_parkolas_id]
        let postbody = pa.joinWithSeparator("&")
        
        
        let route = baseURL + "add_figyelo"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    func list_admonitor(onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")

        let route = baseURL + "list_figyelo"
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func delete_admonitor(id: Int, onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let hir_id = "hir_id=" + String(id)
        
        let pa = [ tokenpost, hir_id]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "delete_figyelo"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
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
