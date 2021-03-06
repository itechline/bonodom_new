//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import SwiftyJSON
import Foundation

enum LeftMenu: Int {
    case Main = 0
    case Swift
    case Java
    case Go
    case NonMenu
    case FavMenu
    case Admonitor
    case AgenciesMenu
    case Invite
    case Logout
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menus = ["Összes Hirdetés", "Személyes", "Üzenetek", "Időpontjaim", "Hirdetéseim", "Kedvenceim","Hirdetésfigyelő","Ügynökség","Meghívás", "Kijelentkezés"]
    var mainViewController: UIViewController!
    var swiftViewController: UIViewController!
    var javaViewController: UIViewController!
    var goViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    var isFavMenuController: UIViewController!
    var advertMonitorController: UIViewController!
    var agenciesVWController: UIViewController!
    var inviteVWController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    var messagesCount: Int = 0
    var appointmentsCount: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        messageCount()
        _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(LeftViewController.messageCount), userInfo: nil, repeats: true)
        //self.tableView.registerCellClass(MenuItemViewController.self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LeftViewController.changeToMain), name: "changeToMain", object: nil)
        
        self.tableView.registerCellNib(MenuItemView.self)
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewControllerWithIdentifier("SwiftViewController") as! SwiftViewController
        self.swiftViewController = UINavigationController(rootViewController: swiftViewController)
        
        let javaViewController = storyboard.instantiateViewControllerWithIdentifier("JavaViewController") as! JavaViewController
        self.javaViewController = UINavigationController(rootViewController: javaViewController)
        
        let goViewController = storyboard.instantiateViewControllerWithIdentifier("GoViewController") as! GoViewController
        self.goViewController = UINavigationController(rootViewController: goViewController)
        
        let nonMenuController = storyboard.instantiateViewControllerWithIdentifier("NonMenuController") as! NonMenuController
        nonMenuController.delegate = self
        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        let isFavMenuController = storyboard.instantiateViewControllerWithIdentifier("FavMenuController") as! FavMenuController
        self.isFavMenuController = UINavigationController(rootViewController: isFavMenuController)
        
        let advertMonitorController = storyboard.instantiateViewControllerWithIdentifier("AdMonitorController") as! AdMonitorController
        self.advertMonitorController = UINavigationController(rootViewController: advertMonitorController)
        
        let agenciesVWController = storyboard.instantiateViewControllerWithIdentifier("AgenciesViewController") as! AgenciesViewController
        self.agenciesVWController = UINavigationController(rootViewController: agenciesVWController)
        
        let inviteVWController = storyboard.instantiateViewControllerWithIdentifier("InviteViewController") as! InviteViewController
        self.inviteVWController = UINavigationController(rootViewController: inviteVWController)
        
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func messageCount()
    {
        //count
        MessageUtil.sharedInstance.getMessagecount { (json: JSON) in
            //print ("MESSAGES",json)
            if (!json["error"].boolValue) {
                dispatch_async(dispatch_get_main_queue(),{
                    self.messagesCount = json["count"].intValue
                    self.tableView.reloadData()
                })
            }
        }
        
        BookingUtil.sharedInstance.get_idpontcount { (json: JSON) in
            //print ("BOOKINGS",json)
            if (!json["error"].boolValue) {
                dispatch_async(dispatch_get_main_queue(),{
                    self.appointmentsCount = json["count"].intValue
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Main:
            let fav: [String:AnyObject] = [ "isFavs": "0"]
            NSNotificationCenter.defaultCenter().postNotificationName("setShowingFavs", object: fav)
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .Swift:
            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        case .Java:
            self.slideMenuController()?.changeMainViewController(self.javaViewController, close: true)
        case .Go:
            self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
        case .NonMenu:
            //HIRDETÉSEIM
            NSNotificationCenter.defaultCenter().postNotificationName("setJustMe", object: nil)
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
            //self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        case .FavMenu:
            let fav: [String:AnyObject] = [ "isFavs": "1"]
            NSNotificationCenter.defaultCenter().postNotificationName("setShowingFavs", object: fav)
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
            //self.slideMenuController()?.changeMainViewController(self.isFavMenuController, close: true)
        case .Admonitor:
            self.slideMenuController()?.changeMainViewController(self.advertMonitorController, close: true)
        case .AgenciesMenu:
            self.slideMenuController()?.changeMainViewController(self.agenciesVWController, close: true)
        case .Invite:
            self.slideMenuController()?.changeMainViewController(self.inviteVWController, close: true)
        case .Logout:
            closeLeft()
            NSNotificationCenter.defaultCenter().postNotificationName("logout", object: nil)
            print ("Kijelentkezés")
        }
    }
    
    func changeToMain() {
        let fav: [String:AnyObject] = [ "isFavs": "2"]
        NSNotificationCenter.defaultCenter().postNotificationName("setShowingFavs", object: fav)
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            switch menu {
            case .Main, .Swift, .Java, .Go, .NonMenu, .FavMenu, .Admonitor, .AgenciesMenu, .Invite, .Logout:
                return MenuItemView.height()
            }
        }
        return 0
    }
}

var logoImage: [UIImage] = [
    UIImage(named: "ic_action_all_ad")!,
    UIImage(named: "ic_action_prof")!,
    UIImage(named: "ic_action_envelop")!,
    UIImage(named: "ic_action_card")!,
    UIImage(named: "ic_action_house")!,
    UIImage(named: "ic_action_heart")!,
    UIImage(named: "ic_action_binocular")!,
    UIImage(named: "ic_action_agencies")!,
    UIImage(named: "ic_action_users")!,
    UIImage(named: "ic_action_logout")!
]

extension LeftViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    /*func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MenuItemView.identifier) as! MenuItemView
        let data = MenuItemViewCellData(imageUrl_menu: "dummy", text_menu: menus[indexPath.row])
        cell.setData(data)
        return cell
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MenuItemView.identifier) as! MenuItemView
        
        switch indexPath.row {
        case 2:
            let data = MenuItemViewCellData2(imagePath_menu: logoImage[indexPath.row], text_menu: menus[indexPath.row], messages: messagesCount, appointment: 0)
            cell.setData(data)
            break
        case 3:
            let data = MenuItemViewCellData2(imagePath_menu: logoImage[indexPath.row], text_menu: menus[indexPath.row], messages: 0, appointment: appointmentsCount)
            cell.setData(data)
            break
        default:
            let data = MenuItemViewCellData2(imagePath_menu: logoImage[indexPath.row], text_menu: menus[indexPath.row], messages: 0, appointment: 0)
            cell.setData(data)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
}

extension LeftViewController: UIScrollViewDelegate {
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}
