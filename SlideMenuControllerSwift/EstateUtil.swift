//
//  RestApiUtil.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 06..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class EstateUtil: NSObject {
    static let sharedInstance = EstateUtil()
    
    let baseURL = "https://bonodom.com/api/"
    
    func getEstateList(ingatlan_id: Int, page: Int, fav: Int,etype: Int, ordering: Int, justme: Int ,onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let ingatlan_ = [ "ingatlan_id", String(ingatlan_id)]
        let ingatlanid = ingatlan_.joinWithSeparator("=")
        let page_ = [ "page", String(page)]
        let page_send = page_.joinWithSeparator("=")
        let fav_ = [ "favorites", String(fav) ]
        let fav_send = fav_.joinWithSeparator("=")
        let etype_ = [ "etype", String(etype)]
        let etype_send = etype_.joinWithSeparator("=")
        let ordering_ = [ "ordering", String(ordering)]
        let ordering_send = ordering_.joinWithSeparator("=")
        let justme_ = [ "justme", String(justme)]
        let justme_send = justme_.joinWithSeparator("=")
        
        
        
        let pa = [ tokenpost, ingatlanid, page_send, fav_send,  etype_send, ordering_send, justme_send]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "list_estates"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    func getEstate(ingatlan_id: Int, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let ingatlan_ = [ "id", String(ingatlan_id)]
        let ingatlanid = ingatlan_.joinWithSeparator("=")
        
        let pa = [ tokenpost, ingatlanid]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "get_estate"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    
    func setFavorite(ingatlan_id: Int, favorit: Int ,onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let ingatlan_ = [ "ingatlan_id", String(ingatlan_id)]
        let ingatlanid = ingatlan_.joinWithSeparator("=")
        let favorite = [ "favorite", String(favorit)]
        let favorite_post = favorite.joinWithSeparator("=")
        
        let pa = [ tokenpost, ingatlanid, favorite_post]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "set_favorite"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    
    
    
    func addEstate(title: String, varos: String, utca: String, leiras: String, ar: String, meret: String,
                   energiatan_id: String, butorozott: String, kilatas_id: String,
                   lift: String, futestipus_id: String, parkolas_id: String, erkely: String,
                   tipus_id: String, emelet_id: String, allapot_id: String, szsz_id: String,
                   lat: String, lng: String, e_type_id: String, zipcode: String, hsz: String,
                   mon: String, tue: String, wed: String, thu: String, fri: String, sat: String,
                   sun: String, start: String, finish: String, onCompletion: (JSON) -> Void) {
        
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let title_post = "ingatlan_title=" + title
        let varos_post = "ingatlan_varos=" + varos
        let utca_post = "ingatlan_utca=" + utca
        let hsz_post = "ingatlan_hsz=" + hsz
        let leiras_post = "ingatlan_rovidleiras=" + leiras
        let ar_post = "ingatlan_ar=" + ar
        let meret_post = "ingatlan_meret=" + meret
        let energiatan_post = "ingatlan_energiatan_id=" + energiatan_id
        let butor_post = "ingatlan_butorozott=" + butorozott
        let kilatas_post = "ingatlan_kilatas_id=" + kilatas_id
        let lift_post = "ingatlan_lift=" + lift
        let futes_post = "ingatlan_futestipus_id=" + futestipus_id
        let parkolas_post = "ingatlan_parkolas_id=" + parkolas_id
        let erkely_post = "ingatlan_erkely=" + erkely
        let tipus_post = "ingatlan_tipus_id=" + tipus_id
        let emelet_post = "ingatlan_emelet_id=" + emelet_id
        let allapot_post = "ingatlan_allapot_id=" + allapot_id
        let szsz_post = "ingatlan_szsz_id=" + szsz_id
        let lat_post = "ingatlan_lat=" + lat
        let lng_post = "ingatlan_lng=" + lng
        let e_type_post = "ing_e_type_id=" + e_type_id
        let zipcode_post = "ingatlan_irszam=" + zipcode
        let mon_post = "mon=" + mon
        let tue_post = "tue=" + tue
        let wed_post = "wed=" + wed
        let thu_post = "thu=" + thu
        let fri_post = "fri=" + fri
        let sat_post = "sat=" + sat
        let sun_post = "sun=" + sun
        let start_post = "start=" + start
        let finish_post = "finish=" + finish
 
        let pa = [ tokenpost, title_post, varos_post, utca_post, leiras_post, ar_post, meret_post, energiatan_post, butor_post, kilatas_post, lift_post, futes_post, parkolas_post, erkely_post, tipus_post, emelet_post, allapot_post, szsz_post, lat_post, lng_post, e_type_post, zipcode_post, hsz_post, mon_post, tue_post, wed_post, thu_post, fri_post, sat_post, sun_post, start_post, finish_post]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "add_estate"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }

    
    func jelentes(ingatlan_id: Int, onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let ingatlan_ = [ "ingid", String(ingatlan_id)]
        let ingatlanid = ingatlan_.joinWithSeparator("=")
        
        let pa = [ tokenpost, ingatlanid]
        let postbody = pa.joinWithSeparator("&")
        
        let route = baseURL + "addserto"
        makeHTTPPostRequest(route, body: postbody, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    func vr(onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        let route = baseURL + "addvr"
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func list_map_estates(onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        
        //VISSZAJÖN ARRAYBEN --> ingatlan_id, ingatlan_lat, ingatlan_lng
        
        let route = baseURL + "list_maps_estates"
        makeHTTPPostRequest(route, body: tokenpost, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func send_invites(email1: String, email2: String, email3: String, email4: String, email5: String, onCompletion: (JSON) -> Void) {
        let token = [ "token", SettingUtil.sharedInstance.getToken()]
        let tokenpost = token.joinWithSeparator("=")
        let mail1 = "email1=" + email1
        let mail2 = "email2=" + email2
        let mail3 = "email3=" + email3
        let mail4 = "email4=" + email4
        let mail5 = "email5=" + email5
        
        let pa = [ tokenpost, mail1, mail2, mail3, mail4, mail5]
        let postbody = pa.joinWithSeparator("&")
        
        
        let route = baseURL + "sendmeghivo"
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