//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var mainContens = ["Budapest XII. kerület", "Debrecen Simonffy utca 4-6.", "Debrecen Kassai út 47/b", "Nyírbátor Zrínyi út. 72", "Nyíregyháza Fazekas János tér 23.", "Nyíregyháza Írisz utca 43.", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15","Hozzonide két kolbászokat"]
    
    var items = [EstateListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCellNib(DataTableViewCell.self)
        
        RestApiUtil.sharedInstance.getTokenValidator { (json: JSON) in
            print (json)
            var msg: Bool!
            msg = json["token_active"].boolValue
            if (msg == true) {
                //INGATLAN LISTA BETÖLTÉSE
            } else {
                //let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
                //let loginView = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                //self.navigationController?.pushViewController(loginView, animated: true)
            }
        }
        
        RestApiUtil.sharedInstance.getEstateList("0", page: 0, fav: 0, etype: 0, ordering: 0, justme: 0, onCompletion: { (json: JSON) in
            //print ("ListEstate" + json)
            print (json)
            if let results = json.array {
                for entry in results {
                    //var asd: String!
                    //asd = json["ingatlan_id"].stringValue
                    self.items.append(EstateListModel(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
            }
        })
        
        /*RestApiUtil.sharedInstance.getEstateList { (json: JSON) in
            //print ("ListEstate" + json)
            print (json)
            if let results = json.array {
                for entry in results {
                    //var asd: String!
                    //asd = json["ingatlan_id"].stringValue
                    self.items.append(EstateListModel(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
            }
            
            
        }*/
        


    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension MainViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return DataTableViewCell.height()
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
     
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //KURVÁRADENEMJÓMÉGÍGY
        let cell = self.tableView.dequeueReusableCellWithIdentifier(DataTableViewCell.identifier) as! DataTableViewCell
        for (index, value) in self.items.enumerate() {
            //print("Item \(index + 1): \(value.id)")
            let data = DataTableViewCellData(imageUrl: items[indexPath.row].pic,
                                             adress: String(items[indexPath.row].id),
                                             street: items[indexPath.row].street,
                                             description: items[indexPath.row].description,
                                             size: items[indexPath.row].size,
                                             rooms: items[indexPath.row].rooms,
                                             price: items[indexPath.row].price)
            cell.setData(data)
            return cell
        }
      return UITableViewCell.init()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
