//
//  MessageThreadViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 16/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageThreadViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var items = [MessageModel]()
    var id = 0
    var hsh = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerCellNib(MessageThreadItemView.self)
        
        MessageUtil.sharedInstance.getMessageListForEstate(hsh, uid: id, onCompletion: { (json: JSON) in
            print (json)
            if let results = json.array {
                for entry in results {
                    print ("APPEND DATA")
                    self.items.append(MessageModel(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    //self.alertController.dismissViewControllerAnimated(true, completion: nil)
                    if (results.count != 0) {
                        print ("RELOAD TABLEVIEW")
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

extension MessageThreadViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print ("RETURN HIGHT")
        return MessageThreadItemView.height()
    }
}

extension MessageThreadViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("RETURN ITEMS COUNT")
        return items.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print ("MAKE CELL")
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MessageThreadItemView.identifier) as! MessageThreadItemView
        print ("SET DATA")
        let data = MessageThreadItemData(conv_msg: items[indexPath.row].conv_msg, fromme: items[indexPath.row].fromme)
        print ("SET DATA 2")
        cell.setData(data)
        print ("RETURN CELL")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*let storyboard = UIStoryboard(name: "MessageThreadViewController", bundle: nil)
        let msg = storyboard.instantiateViewControllerWithIdentifier("MessageThreadViewController") as! MessageThreadViewController
        self.navigationController?.pushViewController(msg, animated: true)*/
    }
}