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




/*dikk*/

class SubContentsViewController : UIViewController, LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate {
    
    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!
    
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
        
        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        let bottomRightButton = createButton(floatingFrame, .Up)
        
        //let floatingFrame2 = CGRect(x: 16, y: 16, width: 56, height: 56)
        self.view.addSubview(bottomRightButton)
    
    
    }
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
    
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        print("did Tapped! \(index)")
        liquidFloatingActionButton.close()
        let storyboard = UIStoryboard(name: "AddEstate", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("AddEstate_1") as! AddEstateViewController
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
    
    func setTexts() {
        self.adressText.text = estateItem[0].adress
        self.streetText.text = estateItem[0].street
        self.descriptionText.text = estateItem[0].description
        self.priceText.text = estateItem[0].price
        self.mainImage.setImageFromURL(estateItem[0].pic, indicator: activityIndicator)
    }
}
