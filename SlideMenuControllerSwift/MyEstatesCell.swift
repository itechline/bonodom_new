//
//  MyEstatesCell.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 20..
//  Copyright © 2016. Itechline. All rights reserved.
//



import UIKit
import SwiftyJSON
import SDWebImage


struct MyEstatesCellData {
    
    init(id: Int, imageUrl: String, adress: String, description: String, row: Int) {
        self.id = id
        self.imageUrl = imageUrl
        self.adress = adress
        self.description = description
        self.row = row
    }
    var id: Int
    var imageUrl: String
    var adress: String
    var description: String
    var row: Int
}

class MyEstatesCell : BaseTableViewCell {
    
    var id : Int!
    var row : Int!
    let screensize = UIScreen.mainScreen().bounds
    
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    
    @IBOutlet weak var modifyHeight: NSLayoutConstraint!
    @IBOutlet weak var modifyWidth: NSLayoutConstraint!
    
    @IBOutlet weak var deleteHeight: NSLayoutConstraint!
    @IBOutlet weak var deleteWidth: NSLayoutConstraint!
    
    @IBOutlet weak var upWidth: NSLayoutConstraint!
    @IBOutlet weak var upHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var adress_text: UILabel!
    @IBOutlet weak var description_text: UILabel!
    @IBOutlet weak var estate_image: UIImageView!
    
    @IBOutlet weak var up_text: UIButton!
    @IBAction func up_button(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var modify_text: UIButton!
    @IBAction func modify_button(sender: AnyObject) {
        let mod: [String:AnyObject] = [ "mod": "1", "row": String(row!)]
        NSNotificationCenter.defaultCenter().postNotificationName("estate_adding", object: mod)
    }
    
    @IBOutlet weak var delete_text: UIButton!
    @IBAction func delete_button(sender: AnyObject) {
        let del_id: [String:AnyObject] = [ "del_id":String(id!), "row":String(row!)]
        NSNotificationCenter.defaultCenter().postNotificationName("delete_estate", object: del_id)
        
        /*EstateUtil.sharedInstance.delete_estate(String(self.id), onCompletion: { (json: JSON) in
            print ("DELETE ESTATE")
            print (json)
            dispatch_async(dispatch_get_main_queue(),{
                if (!json["error"].boolValue) {
                    
                } else {
                    
                }
            
            })
        })*/
    }
    
    
    
    override func awakeFromNib() {
        //self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        //self.dataText?.textColor = UIColor(hex: "000000")
        let iconsize = (((screensize.width)-estate_image.frame.width)-20)/5
        let iconwidth = (((screensize.width)-estate_image.frame.width)-20)/4
        
        cellWidth.constant = screensize.width
        modifyWidth.constant = iconwidth
        modifyHeight.constant = iconsize
        deleteWidth.constant = iconwidth
        deleteHeight.constant = iconsize
        upWidth.constant = iconwidth
        upHeight.constant = iconsize
        print("iconsize: ", iconsize)
    }
    
    override class func height() -> CGFloat {
        return 170
    }
    
    
    override func setData(data: Any?) {
        if let data = data as? MyEstatesCellData {
            if (data.imageUrl != "") {
                let url: NSURL = NSURL(string: data.imageUrl)!
                self.estate_image.sd_setImageWithURL(url)
            } else {
                self.estate_image.image = UIImage(named: "noimage")
            }
            self.estate_image.sizeThatFits(CGSize.init(width: 116.0, height: 169.0))
            self.adress_text.text = data.adress
            self.description_text.text = data.description
            self.row = data.row
            
            self.id = data.id
            
            self.delete_text.layer.cornerRadius = 3
            self.delete_text.layer.borderColor = UIColor.redColor().CGColor
            self.delete_text.layer.borderWidth = 1
            
            self.modify_text.layer.cornerRadius = 3
            self.modify_text.layer.borderColor = UIColor.blueColor().CGColor
            self.modify_text.layer.borderWidth = 1
            
            //00D548 -> UP BUTTON COLOR
            self.up_text.layer.cornerRadius = 3
            self.up_text.layer.borderColor = UIColor(hex: "00D548").CGColor
            self.up_text.layer.borderWidth = 1
            
        }
    }
    
    
}

