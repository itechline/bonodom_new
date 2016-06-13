//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

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
    
    var menus = ["Összes Hirdetés", "Személyes", "Üzenetek", "Számlázás", "Hirdetéseim", "Kedvenceim","Hirdetésfigyelő","Ügynökség","Meghívás", "Kijelentkezés"]
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerCellClass(MenuItemViewController.self)
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
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .Swift:
            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        case .Java:
            self.slideMenuController()?.changeMainViewController(self.javaViewController, close: true)
        case .Go:
            self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
        case .NonMenu:
            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        case .FavMenu:
            self.slideMenuController()?.changeMainViewController(self.isFavMenuController, close: true)
        case .Admonitor:
            self.slideMenuController()?.changeMainViewController(self.advertMonitorController, close: true)
        case .AgenciesMenu:
            self.slideMenuController()?.changeMainViewController(self.agenciesVWController, close: true)
        case .Invite:
            self.slideMenuController()?.changeMainViewController(self.inviteVWController, close: true)
        case .Logout:
            print ("Kijelentkezés")
        }
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
        let data = MenuItemViewCellData2(imagePath_menu: logoImage[indexPath.row], text_menu: menus[indexPath.row])
        cell.setData(data)
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
