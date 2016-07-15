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
        
        self.tableView.registerCellNib(MydatesViewCell.self)
        loadList()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    
    func loadList() {
        self.items.removeAll()
        BookingUtil.sharedInstance.get_idoponts_by_user({ (json: JSON) in
            print ("BOOKING BY USER")
            print (json)
            if let results = json.array {
                for entry in results {
                    self.items.append(IdopontokByUserModel(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
            }
            
        })
    }
}


extension GoViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MydatesViewCell.height()
    }
}

extension GoViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MydatesViewCell.identifier) as! MydatesViewCell
        let data = MydatesViewDataCell(id: items[indexPath.row].id, ingatlan_id: items[indexPath.row].ingatlan_id, datum: items[indexPath.row].datum, status: items[indexPath.row].status, fel_id: items[indexPath.row].fel_id, felhasznalo: items[indexPath.row].felhasznalo, mobile: items[indexPath.row].mobile)
        cell.setData(data)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print ("CELL TAPPED", String(items_by_date[indexPath.row].ingatlan_id))
        /*let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
         let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
         subContentsVC.id = items[indexPath.row].id
         subContentsVC.hsh = items[indexPath.row].hashString
         self.navigationController?.pushViewController(subContentsVC, animated: true)
         */
    }
}