//
//  AdMonitorController.swift
//  Bonodom
//
//  Created by Attila Dan on 03/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

class AdMonitorController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var items = [AdmonitorModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCellNib(AdmonitorDataCell.self)
        self.setNavigationBarItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AdMonitorController.delete_admonitor), name: "delete_admonitor", object: nil)
        //load_admonitor_list()
        

        // Do any additional setup after loading the view.
    }
    
    func load_admonitor_list() {
        items.removeAll()
        AdMonitorUtil.sharedInstance.list_admonitor({ (json: JSON) in
            print ("ADMONITOR LIST")
            print (json)
            if let results = json.array {
                for entry in results {
                    self.items.append(AdmonitorModel(json: entry))
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
    
    override func viewDidAppear(animated: Bool) {
        load_admonitor_list()
        super.viewDidAppear(true)
    }
    
    func delete_admonitor(notification: NSNotification) {
        let alert = UIAlertController(title: "Figyelem", message: "Törli a hirdetésfigyelőt?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Nem", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Igen", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                print("default")
                if let info = notification.object as? [String:AnyObject] {
                    if let delete_id = info["id"] as? String {
                        AdMonitorUtil.sharedInstance.delete_admonitor(Int(delete_id)!, onCompletion: { (json: JSON) in
                            print (json)
                            dispatch_async(dispatch_get_main_queue(),{
                                if (!json["error"].boolValue) {
                                    self.load_admonitor_list()
                                    self.tableView.reloadData()
                                } else {
                                    print ("DELETE ERROR")
                                }
                            })
                         })
                    }
                }
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension AdMonitorController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AdmonitorDataCell.height()
    }
}

extension AdMonitorController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(AdmonitorDataCell.identifier) as! AdmonitorDataCell
        let data = AdmonitorData(id: items[indexPath.row].id,
                                 fel_id: items[indexPath.row].fel_id,
                                 name: items[indexPath.row].name,
                                 ingatlan_butorozott: items[indexPath.row].ingatlan_butorozott,
                                 ingatlan_lift: items[indexPath.row].ingatlan_lift,
                                 ingatlan_erkely: items[indexPath.row].ingatlan_erkely,
                                 ingatlan_meret: items[indexPath.row].ingatlan_meret,
                                 ingatlan_szsz_min: items[indexPath.row].ingatlan_szsz_min,
                                 ingatlan_szsz_max: items[indexPath.row].ingatlan_szsz_max,
                                 ingatlan_emelet_max: items[indexPath.row].ingatlan_emelet_max,
                                 ingatlan_emelet_min: items[indexPath.row].ingatlan_emelet_min,
                                 ingatlan_allapot_id: items[indexPath.row].ingatlan_allapot_id,
                                 ingatlan_tipus_id: items[indexPath.row].ingatlan_tipus_id,
                                 ingatlan_energiatan_id: items[indexPath.row].ingatlan_energiatan_id,
                                 ingatlan_kilatas_id: items[indexPath.row].ingatlan_kilatas_id,
                                 ingatlan_parkolas_id: items[indexPath.row].ingatlan_parkolas_id,
                                 ingatlan_ar_max: items[indexPath.row].ingatlan_ar_max,
                                 ingatlan_ar_min: items[indexPath.row].ingatlan_ar_min,
                                 keyword: items[indexPath.row].keyword)
        cell.setData(data)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let main = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        main.admonitor_model = items
        main.admonitor_id = indexPath.row
        main.isAdmonitor = true
        self.navigationController?.pushViewController(main, animated: true)
    }
}
