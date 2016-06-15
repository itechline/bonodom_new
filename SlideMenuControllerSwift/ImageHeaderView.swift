//
//  ImageHeaderCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/3/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

class ImageHeaderView : UIView {
    static let sharedInstance = ImageHeaderView()
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var backgroundImage : UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "ffffff")
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileImage.setRandomDownloadImage(80, height: 80)
        self.profileName.text = "asdf"
        //self.backgroundImage.setRandomDownloadImage(Int(self.frame.size.width), height: 160)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageHeaderView.setName(_:)), name: "logged", object: nil)
    }
    
    func setName(notification: NSNotification) {
        if let userInfo = notification.object as? [String:AnyObject] {
            if let loggedUserName = userInfo["userName"] as? String {
                print(loggedUserName)
                profileName.text = loggedUserName
            }
        }
        
    }
}