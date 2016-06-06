

import UIKit

struct DataTableViewCellData {
    
    init(imageUrl: String, adress: String, street: String,description: String, size: String, rooms: String, price: String) {
        self.imageUrl = imageUrl
        self.adress = adress
        self.street = street
        self.description = description
        self.size = size
        self.rooms = rooms
        self.price = price
    }
    var imageUrl: String
    var adress: String
    var street: String
    var description: String
    var size: String
    var rooms: String
    var price: String
}

class DataTableViewCell : BaseTableViewCell {
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
    
    @IBOutlet weak var sizeText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var roomsText: UILabel!
    
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
            self.dataImage.setImageFromURL(data.imageUrl)
            self.dataText.text = data.adress
            self.sizeText.text = data.size
            self.descriptionText.text = data.description
            self.roomsText.text = data.rooms
            self.streetText.text = data.street
            self.priceText.text = data.price
        }
    }
}
