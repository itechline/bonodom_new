//
//  GoViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items = [IdopontokByUserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    
    func loadList() {
        BookingUtil.sharedInstance.get_idoponts_by_user({ (json: JSON) in
            print ("BOOKING BY USER")
            print (json)
            
        })
    }
}