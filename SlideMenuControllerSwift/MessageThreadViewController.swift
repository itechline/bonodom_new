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
    
    @IBOutlet weak var message_input: UITextField!
    @IBOutlet weak var send_message_text: UIButton!
    @IBAction func send_message_button(sender: AnyObject) {
        let message : String = message_input!.text!
        if (!message.isEmpty) {
        
            MessageUtil.sharedInstance.sendMessage(hsh, msg: message, onCompletion: { (json: JSON) in
            print (json)
                
            dispatch_async(dispatch_get_main_queue(),{
                if (!json["error"].boolValue) {
                    print ("MESSAGE SENT")
                    self.message_input.text = ""
                    self.loadMessages()
                }
                        
            })
                
        })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.tableView.registerCellNib(MessageThreadItemView.self)
        
        loadMessages()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMessages() {
        items.removeAll()
        MessageUtil.sharedInstance.getMessageListForEstate(hsh, uid: id, onCompletion: { (json: JSON) in
            print (json)
            if let results = json.array {
                for entry in results {
                    self.items.append(MessageModel(json: entry))
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

}

extension MessageThreadViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MessageThreadItemView.height()
    }
}

extension MessageThreadViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MessageThreadItemView.identifier) as! MessageThreadItemView
        let data = MessageThreadItemData(conv_msg: items[indexPath.row].conv_msg, fromme: items[indexPath.row].fromme)
        cell.setData(data)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*let storyboard = UIStoryboard(name: "MessageThreadViewController", bundle: nil)
        let msg = storyboard.instantiateViewControllerWithIdentifier("MessageThreadViewController") as! MessageThreadViewController
        self.navigationController?.pushViewController(msg, animated: true)*/
    }
}