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
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Összes Hirdetés", "Személyes", "Üzenetek", "Számlázás", "Hirdetéseim", "Kedvenceim","Hirdetésfigyelő","Ügynökség","Meghívás"]
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
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
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
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            switch menu {
            case .Main, .Swift, .Java, .Go, .NonMenu, .FavMenu, .Admonitor, .AgenciesMenu, .Invite:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.item) {
            switch menu {
            case .Main, .Swift, .Java, .Go, .NonMenu, .FavMenu, .Admonitor, .AgenciesMenu, .Invite:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
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
