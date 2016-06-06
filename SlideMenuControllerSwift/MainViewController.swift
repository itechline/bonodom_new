//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import SOAPEngine64

class MainViewController: UIViewController {
    
    var soap = [SOAPEngine]()
    var verses:NSArray = [NSArray]()

    @IBOutlet weak var tableView: UITableView!
    
    var mainContens = ["Budapest XII. kerület", "Debrecen Simonffy utca 4-6.", "Debrecen Kassai út 47/b", "Nyírbátor Zrínyi út. 72", "Nyíregyháza Fazekas János tér 23.", "Nyíregyháza Írisz utca 43.", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15","Hozzonide két kolbászokat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCellNib(DataTableViewCell.self)
        
        /*let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.licenseKey = "eJJDzkPK9Xx+p5cOH7w0Q+AvPdgK1fzWWuUpMaYCq3r1mwf36Ocw6dn0+CLjRaOiSjfXaFQBWMi+TxCpxVF/FA=="
        //soap.responseHeader = true // use only for non standard MS-SOAP service
        
        soap.setValue("Genesis", forKey: "BookName")
        soap.setIntegerValue(1, forKey: "chapter")
        soap.requestURL("http://www.prioregroup.com/services/americanbible.asmx",
                        soapAction: "http://www.prioregroup.com/GetVerses",
                        completeWithDictionary: { (statusCode : Int, dict : [NSObject : AnyObject]!) -> Void in
                            
                            var book:Dictionary = dict as Dictionary
                            let verses:NSArray = book["BibleBookChapterVerse"] as! NSArray
                            self.verses = verses
                            //self.table.reloadData()
                            print(verses)
                            
        }) { (error : NSError!) -> Void in
            
            NSLog("%@", error)
        }*/
        
        //token: 40ce974b2e4bd7550323f6da7e752bae
        
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.licenseKey = "eJJDzkPK9Xx+p5cOH7w0Q+AvPdgK1fzWWuUpMaYCq3r1mwf36Ocw6dn0+CLjRaOiSjfXaFQBWMi+TxCpxVF/FA=="
        //soap.responseHeader = true // use only for non standard MS-SOAP service
        soap.setValue("608f44981dd5241547605947c1dc38e0", forKey:"token")
        
        //soap.token = "608f44981dd5241547605947c1dc38e0"
        //soap.setValue("Genesis", forKey: "BookName")
        //soap.setIntegerValue(1, forKey: "chapter")
        
    
        
        soap.requestURL("https://bonodom.com/api/token_validator",
                        soapAction: "",
                        complete: { (statusCode : Int, stringXML : String!) -> Void in
                            
                            
                            //let book:Dictionary = dict as Dictionary
                            //let verses:NSArray = book["BibleBookChapterVerse"] as! NSArray
                            //self.verses = verses
                            //self.table.reloadData()
                        
                            print("LOFASZ " + stringXML)
                            
        }) { (error : NSError!) -> Void in
            
            NSLog("%@", error)
        }


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
        return self.mainContens.count
    }
     
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(DataTableViewCell.identifier) as! DataTableViewCell
        let data = DataTableViewCellData(imageUrl: "dummy", text: mainContens[indexPath.row])
        cell.setData(data)
        return cell
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
