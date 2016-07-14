

import UIKit
import SwiftyJSON
import SDWebImage


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
        print ("ID")
        print (self.id)
        print ("FAVORITE")
        print (favToSend)
        EstateUtil.sharedInstance.setFavorite(self.id, favorit: favToSend, onCompletion: { (json: JSON) in
            print (json)
            dispatch_async(dispatch_get_main_queue(),{
                if (!json["error"].boolValue) {
                    if (favToSend == 0) {
                        print ("NOT FAV")
                        print (self.id)
                        self.favorite = false
                        self.heart_button.setImage(UIImage(named: "heart_empty")!, forState: UIControlState.Normal)
                    } else {
                        print ("FAV")
                        self.favorite = true
                        print (self.id)
                        self.heart_button.setImage(UIImage(named: "heart_filled")!, forState: UIControlState.Normal)
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
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let contextImage: UIImage = UIImage(CGImage: image.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    
    override func setData(data: Any?) {
        if let data = data as? DataTableViewCellData {
            //self.dataImage.setRandomDownloadImage(100, height: 170)
            //self.dataImage.setImageFromURL(data.imageUrl, indicator: activityIndicator)
            if (data.imageUrl != "") {
                let url: NSURL = NSURL(string: data.imageUrl)!
                print ("URLGECI", url)
                self.dataImage.sd_setImageWithURL(url)
            } else {
                self.dataImage.image = UIImage(named: "noimage")
            }
            self.dataImage.sizeThatFits(CGSize.init(width: 116.0, height: 169.0))
            self.dataText.text = data.adress
            self.sizeText.text = data.size
            self.descriptionText.text = data.description
            self.roomsText.text = data.rooms
            self.streetText.text = data.street
            self.favorite = data.fav
            self.id = data.id
            
            if (self.favorite == true) {
                self.heart_button.setImage(UIImage(named: "heart_filled")!, forState: UIControlState.Normal)
            } else {
                self.heart_button.setImage(UIImage(named: "heart_empty")!, forState: UIControlState.Normal)
            }
            
            if (data.e_type == 1) {
                self.priceText.text = data.price + " Ft"
            } else {
                self.priceText.text = data.price + " Ft/hó"
            }
        }
    }
    
    
}
