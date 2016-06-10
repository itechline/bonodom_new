//
//  SubContentsViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/8/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SwiftyJSON




/*dikk*/


class SubContentsViewController : UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var advertiserName: UILabel!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var adressText: UILabel!
    @IBOutlet weak var streetText: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var id = 0;
    
    var estateItem = [EstateModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setTexts("FASZ")
        EstateUtil.sharedInstance.getEstate(id, onCompletion: { (json: JSON) in
            self.estateItem.append(EstateModel(json: json))
            dispatch_async(dispatch_get_main_queue(),{
                //self.tableView.reloadData()
                self.setTexts()
            })
        })
    
    
    }
    
    func setTexts() {
        self.adressText.text = estateItem[0].adress
        self.streetText.text = estateItem[0].street
        self.descriptionText.text = estateItem[0].description
        self.priceText.text = estateItem[0].price
        self.mainImage.setImageFromURL(estateItem[0].pic, indicator: activityIndicator)
    }
}
