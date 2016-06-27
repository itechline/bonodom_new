

import UIKit
import SwiftyJSON

struct DataTableViewCellData {
    
    init(id: Int, imageUrl: String, adress: String, street: String,description: String, size: String, rooms: String, price: String, e_type: Int, fav: Bool) {
        self.id = id
        self.imageUrl = imageUrl
        self.adress = adress
        self.street = street
        self.description = description
        self.size = size
        self.rooms = rooms
        self.price = price
        self.e_type = e_type
        self.fav = fav
    }
    var id: Int
    var imageUrl: String
    var adress: String
    var street: String
    var description: String
    var size: String
    var rooms: String
    var price: String
    var e_type: Int
    var fav: Bool
}

class DataTableViewCell : BaseTableViewCell {
    
    var favorite : Bool!
    var id : Int!
    @IBOutlet weak var heart_button: UIButton!
    @IBAction func heart_button_action(sender: AnyObject) {
        var favToSend = 0
        if (self.favorite == true) {
            favToSend = 0
        } else {
            favToSend = 1
        }
        EstateUtil.sharedInstance.setFavorite(self.id, favorit: favToSend, onCompletion: { (json: JSON) in
            print (json)
            dispatch_async(dispatch_get_main_queue(),{
                if (!json["error"].boolValue) {
                    if (favToSend == 0) {
                        print ("NOT FAV")
                        print (self.id)
                        self.favorite = false
                    } else {
                        print ("FAV")
                        self.favorite = true
                        print (self.id)
                    }
                } else {
                    
                }
            })
        })
    }
    
    
    
    @IBOutlet weak var dataImage: UIImageView!
    
    @IBOutlet weak var dataText: UILabel!
    
    @IBOutlet weak var sizeText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var roomsText: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var streetText: UILabel!
    override func awakeFromNib() {
        self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        self.dataText?.textColor = UIColor(hex: "000000")
    }
 
    override class func height() -> CGFloat {
        return 170
    }
    
    
    override func setData(data: Any?) {
        if let data = data as? DataTableViewCellData {
            //self.dataImage.setRandomDownloadImage(100, height: 170)
            self.dataImage.setImageFromURL(data.imageUrl, indicator: activityIndicator)
            self.dataImage.sizeThatFits(CGSize.init(width: 100.0, height: 169.0))
            self.dataText.text = data.adress
            self.sizeText.text = data.size
            self.descriptionText.text = data.description
            self.roomsText.text = data.rooms
            self.streetText.text = data.street
            self.favorite = data.fav
            self.id = data.id
            if (data.e_type == 1) {
                self.priceText.text = data.price + " Ft"
            } else {
                self.priceText.text = data.price + " Ft/hó"
            }
        }
    }
    
    
}
