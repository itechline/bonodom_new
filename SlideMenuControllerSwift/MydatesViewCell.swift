//
//  MydatesViewCell.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 15..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

struct MydatesViewDataCell{
    
    init(id: Int, ingatlan_id: Int, datum: String, status: Int, fel_id: Int, felhasznalo: String, mobile: String){
        self.id = id
        self.ingatlan_id = ingatlan_id
        self.datum = datum
        self.status = status
        self.fel_id = fel_id
        self.felhasznalo = felhasznalo
        self.mobile = mobile
    }
    var id: Int
    var ingatlan_id: Int
    var datum: String
    var status: Int
    var fel_id: Int
    var felhasznalo: String
    var mobile: String
}
class MydatesViewCell: BaseMenuItemViewController {
    var id = 0
    var status = 0
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var elutasit_text: UIButton!
    @IBAction func elutasit_button(sender: AnyObject) {
        if (self.status == 0) {
            BookingUtil.sharedInstance.update_idopont(id, status: 2, onCompletion: { (json: JSON) in
                print ("ELUTASIT")
                print (json)
                    dispatch_async(dispatch_get_main_queue(),{
                        self.elutasit_text.hidden = false
                        self.elfogad_text.hidden = true
                        self.elutasit_text.setTitle("Elutasitva", forState: UIControlState.Normal)
                    })
            })
        }
    }
    
    @IBOutlet weak var elfogad_text: UIButton!
    @IBAction func elfogad_button(sender: AnyObject) {
        if (self.status == 0) {
            BookingUtil.sharedInstance.update_idopont(id, status: 1, onCompletion: { (json: JSON) in
                print ("ELFOGAD")
                print (json)
                dispatch_async(dispatch_get_main_queue(),{
                    self.elutasit_text.hidden = true
                    self.elfogad_text.hidden = false
                    self.elfogad_text.setTitle("Elfogadva", forState: UIControlState.Normal)
                })
            })
        }
    }
    
    var phonenumber = ""
    @IBAction func phone_button(sender: AnyObject) {
        if (phonenumber != "") {
            if let url = NSURL(string: "tel://\(self.phonenumber)") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    override func awakeFromNib() {
        //self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        //self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 110
    }
    
    override func setData(data: Any?){
        if let data = data as? MydatesViewDataCell{
            self.name.text = data.felhasznalo
            self.date.text = data.datum
            self.phonenumber = data.mobile
            self.id = data.id
            self.status = data.status
            switch data.status {
            case 0:
                //NINCS MÉG ELDÖNTVE
                elutasit_text.hidden = false
                elfogad_text.hidden = false
                elfogad_text.setTitle("Elfogad", forState: UIControlState.Normal)
                elutasit_text.setTitle("Elutasít", forState: UIControlState.Normal)
                print ("STATUS 0")
                break
            case 1:
                //ELFOGADVA
                elutasit_text.hidden = true
                elfogad_text.hidden = false
                elfogad_text.setTitle("Elfogadva", forState: UIControlState.Normal)
                print ("STATUS 1")
                break
            default:
                //ELUTASITVA
                elfogad_text.hidden = true
                elutasit_text.hidden = false
                elutasit_text.setTitle("Elutasítva", forState: UIControlState.Normal)
                print ("STATUS 2")
            }
        }
    }
    
}
