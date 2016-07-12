//
//  SubContentsViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/8/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SwiftyJSON
import LiquidFloatingActionButton

class SubContentsViewController : UIViewController, LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate {
    
    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var advertiserName: UILabel!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var adressText: UILabel!
    @IBOutlet weak var streetText: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var szobaszam: UILabel!
    @IBOutlet weak var meret: UILabel!
    @IBOutlet weak var tipus: UILabel!
    @IBOutlet weak var lift: UILabel!
    @IBOutlet weak var erkely: UILabel!
    @IBOutlet weak var parkolas: UILabel!
    
    @IBOutlet weak var kilatas: UILabel!
    @IBOutlet weak var allapot: UILabel!
    @IBOutlet weak var szintek: UILabel!
    @IBOutlet weak var futes: UILabel!
    @IBOutlet weak var etan: UILabel!
    @IBOutlet weak var butor: UILabel!
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var id = 0;
    
    var estateItem = [EstateModel]()
    var hsh = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setTexts("FASZ")
        EstateUtil.sharedInstance.getEstate(id, onCompletion: { (json: JSON) in
            self.estateItem.append(EstateModel(json: json))
            print ("ESTATE")
            print (json)
            dispatch_async(dispatch_get_main_queue(),{
                //self.tableView.reloadData()
                self.setTexts()
            })
        })
        
        let createButton: (CGRect, LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton = { (frame, style) in
            let floatingActionButton = LiquidFloatingActionButton(frame: frame)
            floatingActionButton.animateStyle = style
            floatingActionButton.dataSource = self
            floatingActionButton.delegate = self
            //floatingActionButton.isAddEstateButton = true
            //floatingActionButton.isPhoneButton = true
            //floatingActionButton.image = UIImage(named: "ic_action_heart")
            return floatingActionButton
        }
        
        let cellFactory: (String) -> LiquidFloatingCell = { (iconName) in
            return LiquidFloatingCell(icon: UIImage(named: iconName)!)
        }
        cells.append(cellFactory("ic_action_envelop"))
        cells.append(cellFactory("ic_action_heart"))
        cells.append(cellFactory("ic_action_envelop"))
        
        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        let bottomRightButton = createButton(floatingFrame, .Up)
        
        self.view.addSubview(bottomRightButton)
    }
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
    
    var mobile = ""
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        print("did Tapped! \(index)")
        if (index == 2) {
            if let url = NSURL(string: "tel://\(mobile)") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        if (index == 0) {
            let storyboard = UIStoryboard(name: "MessageThreadView", bundle: nil)
            let msg = storyboard.instantiateViewControllerWithIdentifier("MessageThreadViewController") as! MessageThreadViewController
            msg.id = 0
            msg.hsh = hsh
            self.navigationController?.pushViewController(msg, animated: true)
        }
        liquidFloatingActionButton.close()
    }
    
    func setTexts() {
        self.advertiserName.text = estateItem[0].vezeteknev + " " + estateItem[0].keresztnev
        self.adressText.text = estateItem[0].ingatlan_title
        self.streetText.text = estateItem[0].adress + " " + estateItem[0].street
        self.descriptionText.text = estateItem[0].description
        self.priceText.text = estateItem[0].price
        self.meret.text = estateItem[0].size
        self.szobaszam.text = estateItem[0].ingatlan_szsz
        self.tipus.text = estateItem[0].ingatlan_tipus
        self.parkolas.text = estateItem[0].ingatlan_parkolas
        self.kilatas.text = estateItem[0].ingatlan_kilatas
        self.allapot.text = estateItem[0].ingatlan_allapot
        self.szintek.text = estateItem[0].ingatlan_emelet
        self.futes.text = estateItem[0].ingatlan_futestipus
        self.etan.text = estateItem[0].ingatlan_energiatan
        self.mobile = estateItem[0].mobil
        
        
        if (estateItem[0].ing_e_type_id == 1) {
            self.priceText.text = estateItem[0].price + " Ft"
        } else {
            self.priceText.text = estateItem[0].price + " Ft/hó"
        }
        
        if (estateItem[0].ingatlan_lift == 1) {
            self.lift.text = "Van"
        } else {
            self.lift.text = "Nincs"
        }
        
        if (estateItem[0].ingatlan_erkely == 1) {
            self.erkely.text = "Van"
        } else {
            self.erkely.text = "Nincs"
        }
        
        if (estateItem[0].ingatlan_butorozott == 1) {
            self.butor.text = "Nem"
        } else if (estateItem[0].ingatlan_butorozott == 2){
            self.butor.text = "Igen"
        } else {
            self.butor.text = "Alku tárgya"
        }
        
        self.mainImage.setImageFromURL(estateItem[0].pic, indicator: activityIndicator)
    }
    
    
    @IBAction func virtual_reality_button(sender: AnyObject) {
        EstateUtil.sharedInstance.vr({ (json: JSON) in
            print ("VIRTUAL REALITY")
            print (json)
        })
    }
    
    @IBAction func hibas_serto_button(sender: AnyObject) {
        let alert = UIAlertController(title: "Figyelem!", message: "Jelenti a hirdetést?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Nem", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Igen", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                EstateUtil.sharedInstance.jelentes(self.id, onCompletion: { (json: JSON) in
                    print ("HIBAS SERTO")
                    print (json)
                })
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func see_on_maps_button(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "MapsViewController", bundle: nil)
        let maps = storyboard.instantiateViewControllerWithIdentifier("Maps") as! MapsViewController
        self.navigationController?.pushViewController(maps, animated: true)
    }
    
}
