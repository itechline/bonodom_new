//
//  MenuItemViewController.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 06..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit

struct MenuItemViewCellData {
    
    init(imageUrl_menu: String, text_menu: String) {
        self.imageUrl_menu = imageUrl_menu
        self.text_menu = text_menu
    }
    var imageUrl_menu: String
    var text_menu: String
}

class MenuItemView: BaseMenuItemViewController {

    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
    
    override func awakeFromNib() {
        self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 30
    }
    
    override func setData(data: Any?) {
        if let data = data as? MenuItemViewCellData {
            self.dataImage.setRandomDownloadImage(50, height: 50)
            self.dataText.text = data.text_menu
        }
    }

}
