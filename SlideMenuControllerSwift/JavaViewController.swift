//
//  JavaViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SwiftyJSON

class JavaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items = [MessagesListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCellNib(MessageTableCell.self)
        // Do any additional setup after loading the view.
        
        MessageUtil.sharedInstance.getMessageList({ (json: JSON) in
            print ("MESSAGES")
            print (json)
            if let results = json.array {
                for entry in results {
                    self.items.append(MessagesListModel(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    //self.alertController.dismissViewControllerAnimated(true, completion: nil)
                    if (results.count != 0) {
                        self.tableView.reloadData()
                    }
                })
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension JavaViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MessageTableCell.height()
    }
}

extension JavaViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MessageTableCell.identifier) as! MessageTableCell
        let data = MessageTableCellData(date: items[indexPath.row].date, fel_vezeteknev: items[indexPath.row].fel_vezeteknev, fel_keresztnev: items[indexPath.row].fel_keresztnev, ingatlan_varos: items[indexPath.row].ingatlan_varos, ingatlan_utca: items[indexPath.row].ingatlan_utca, hash: items[indexPath.row].hash, uid: items[indexPath.row].uid)
        cell.setData(data)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print (items[indexPath.row].uid)
        /*let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
         let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
         subContentsVC.id = items[indexPath.row].id
         self.navigationController?.pushViewController(subContentsVC, animated: true)*/
    }
}