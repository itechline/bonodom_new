//
//  SubContentsViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/8/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

struct SubContentsViewData {
    
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

class SubContentsViewController : UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var advertiserName: UILabel!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var adressText: UILabel!
    @IBOutlet weak var streetText: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setData(data: Any?) {
        if let data = data as? DataTableViewCellData {
            self.descriptionText.text = data.description
            self.streetText.text = data.street
            self.priceText.text = data.price
            self.adressText.text = data.adress
            //self.mainImage.setImageFromURL(data.imageUrl, indicator: nil)
        }
    }
}
