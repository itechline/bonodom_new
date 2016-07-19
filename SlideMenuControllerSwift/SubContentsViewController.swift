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
import ImageSlideshow
import SDWebImage
import NBMaterialDialogIOS

class SubContentsViewController : UIViewController, LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate {
    
    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!
    
    @IBOutlet var slideshow: ImageSlideshow!
    
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

    @IBOutlet weak var profile_pic: UIImageView!
    
    var id = 0;
    
    var estateItem = [EstateModel]()
    var hsh = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EstateUtil.sharedInstance.getEstate(id, onCompletion: { (json: JSON) in
            self.estateItem.append(EstateModel(json: json))
            print ("ESTATE")
            print (json)
            dispatch_async(dispatch_get_main_queue(),{
                //self.tableView.reloadData()
                self.setTexts()
                self.loadSlideShow()
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
        cells.append(cellFactory("ic_action_phone_b"))
        cells.append(cellFactory("ic_action_idopont"))
        
        
        
        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        let bottomRightButton = createButton(floatingFrame, .Up)
        
        self.view.addSubview(bottomRightButton)
    }
    
    func loadSlideShow() {
        if (!estateItem[0].pictures.isEmpty) {
            print ("LOADING SLIDER")
            var images: [InputSource] = []
            slideshow.backgroundColor = UIColor.whiteColor()
            slideshow.slideshowInterval = 5.0
            slideshow.pageControlPosition = PageControlPosition.UnderScrollView
            slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor();
            slideshow.pageControl.pageIndicatorTintColor = UIColor.blackColor();

            for i in 0...estateItem[0].pictures.count-1 {
                let link = estateItem[0].pictures[i]
                print ("LINK", link)
                images.append(AlamofireSource(urlString: link)!)
            }
            slideshow.setImageInputs(images)

            let recognizer = UITapGestureRecognizer(target: self, action: #selector(SubContentsViewController.click))
            slideshow.addGestureRecognizer(recognizer)
        } else {
            print("HIDING SLIDER")
            slideshow.hidden = true
        }
    }
    
    func click() {
        let ctr = FullScreenSlideshowViewController()
        ctr.pageSelected = {(page: Int) in
            self.slideshow.setScrollViewPage(page, animated: false)
        }
        
        //ctr.initialImageIndex = slideshow.scrollViewPage
        ctr.inputs = slideshow.images
        //self.transitionDelegate = ZoomAnimatedTransitioningDelegate(slideshowView: slideshow, slideshowController: ctr)
        
        
        // Uncomment if you want disable the slide-to-dismiss feature
        // self.transitionDelegate?.slideToDismissEnabled = false
        
        
        //ctr.transitioningDelegate = self.transitionDelegate
        self.presentViewController(ctr, animated: true, completion: nil)
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
        
        switch index {
        case 0:
            let storyboard = UIStoryboard(name: "MessageThreadView", bundle: nil)
            let msg = storyboard.instantiateViewControllerWithIdentifier("MessageThreadViewController") as! MessageThreadViewController
            msg.id = 0
            msg.hsh = hsh
            self.navigationController?.pushViewController(msg, animated: true)
            break
        case 1:
            if (estateItem[0].kedvenc == true) {
                addToFav(estateItem[0].id, favToSend: 0)
            } else {
                addToFav(estateItem[0].id, favToSend: 1)
            }
            break
        case 2:
            if let url = NSURL(string: "tel://\(mobile)") {
                UIApplication.sharedApplication().openURL(url)
            }
            break
        default:
            let storyboard = UIStoryboard(name: "BookingViewController", bundle: nil)
            let booking = storyboard.instantiateViewControllerWithIdentifier("Booking") as! BookingViewController
            booking.id = id
            booking.start = estateItem[0].start
            booking.finish = estateItem[0].finish
            booking.hetfo = estateItem[0].hetfo
            booking.kedd = estateItem[0].kedd
            booking.szerda = estateItem[0].szerda
            booking.csutortok = estateItem[0].csutortok
            booking.pentek = estateItem[0].pentek
            booking.szombat = estateItem[0].szombat
            booking.vasarnap = estateItem[0].vasarnap
            
            
            self.navigationController?.pushViewController(booking, animated: true)
            break
        }
        liquidFloatingActionButton.close()
    }
    
    func addToFav(id: Int, favToSend: Int) {
        EstateUtil.sharedInstance.setFavorite(self.id, favorit: favToSend, onCompletion: { (json: JSON) in
            print (json)
            dispatch_async(dispatch_get_main_queue(),{
                if (!json["error"].boolValue) {
                    if (favToSend == 0) {
                        print ("NOT FAV")
                        self.cells[1].imageView.image = UIImage(named: "heart_empty")
                    } else {
                        print ("FAV")
                        self.cells[1].imageView.image = UIImage(named: "ic_action_heart")
                    }
                } else {
                    if (favToSend == 0) {
                        print ("NOT FAV")
                        self.cells[1].imageView.image = UIImage(named: "ic_action_heart")
                    } else {
                        print ("FAV")
                        self.cells[1].imageView.image = UIImage(named: "heart_empty")
                    }
                }
            })
        })
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
        
        if (!estateItem[0].face.isEmpty) {
            let url: NSURL = NSURL(string: "https://bonodom.com/profil/img/250_250/" + estateItem[0].face)!
            self.profile_pic.sd_setImageWithURL(url)
            self.profile_pic.layer.cornerRadius = self.profile_pic.frame.size.height / 2
            self.profile_pic.clipsToBounds = true
            
        }
        
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
        if (estateItem[0].ingatlan_lat != 0.0 && estateItem[0].ingatlan_lng != 0.0) {
            let storyboard = UIStoryboard(name: "MapsViewController", bundle: nil)
            let maps = storyboard.instantiateViewControllerWithIdentifier("Maps") as! MapsViewController
            maps.lat = estateItem[0].ingatlan_lat
            maps.lng = estateItem[0].ingatlan_lng
            self.navigationController?.pushViewController(maps, animated: true)
        } else {
            NBMaterialSnackbar.showWithText(view, text: "Az ingatlan nem tekinthető meg a térképen!", duration: NBLunchDuration.SHORT)
        }
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
    
}
