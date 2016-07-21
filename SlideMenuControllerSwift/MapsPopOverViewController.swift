//
//  MapsPopOverViewController.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 18..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class MapsPopOverViewController: UIViewController {
    
    @IBOutlet var main_view: UIView!
    
    @IBOutlet weak var adress_text: UILabel!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var price_text: UILabel!
    @IBOutlet weak var street_text: UILabel!
    @IBOutlet weak var description_text: UILabel!
    
    @IBOutlet weak var size_text: UILabel!
    @IBOutlet weak var roomcount_text: UILabel!
    @IBOutlet weak var furniture_image: UIImageView!
    
    
    var estateItem = [EstateModel]()
    
    var id = ""
    var hsh = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.estateItem.removeAll()
        print ("ID", id)
        EstateUtil.sharedInstance.getEstate(Int(id)!, onCompletion: { (json: JSON) in
            self.estateItem.append(EstateModel(json: json))
            print ("ESTATE")
            print (json)
            dispatch_async(dispatch_get_main_queue(),{
                self.setDatas()
            })
        })
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapsPopOverViewController.openContentEstate))
        main_view!.addGestureRecognizer(tap)
    }
    
    func openContentEstate() {
        let tmpController :UIViewController! = self.presentingViewController;
        
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            tmpController.dismissViewControllerAnimated(true, completion: nil);
        });
        
        NSNotificationCenter.defaultCenter().postNotificationName("openContentEstate", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setDatas() {
        if (!estateItem[0].pictures.isEmpty) {
            print ("PICTURE", estateItem[0].pictures[0])
            let url: NSURL = NSURL(string: estateItem[0].pictures[0])!
            self.image_view.sd_setImageWithURL(url)
            //self.image_view.setImageFromURLWhithoutIndicator(estateItem[0].pictures[0])
        }
        self.adress_text.text = estateItem[0].adress
        self.street_text.text = estateItem[0].street
        self.description_text.text = estateItem[0].description
        self.size_text.text = estateItem[0].size
        self.roomcount_text.text = estateItem[0].ingatlan_szsz
        
        if (estateItem[0].ing_e_type_id == 1) {
            //self.price_text.text = estateItem[0].price + " Ft"
            self.price_text.text = estateItem[0].price.asLocaleCurrency + " Ft"
        } else {
            //self.price_text.text = estateItem[0].price + " Ft/hó"
            self.price_text.text = estateItem[0].price.asLocaleCurrency + " Ft/hó"
        }
        
        if (estateItem[0].ingatlan_butorozott == 2) {
            //NINCS
            self.furniture_image.image = UIImage(named: "list_nofurniture")
        } else {
            self.furniture_image.image = UIImage(named: "list_furniture")
        }
    }

}
