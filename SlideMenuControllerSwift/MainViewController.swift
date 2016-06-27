//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import SwiftyJSON
import LiquidFloatingActionButton

class MainViewController: UIViewController, LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var items = [EstateListModel]()
    var currentPage = 0
    
    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!
    
    var imagePicker = UIImagePickerController()
    
    var largest_id = 0
    
    var elado_kiado_items = [SpinnerModel]()
    var pickerData_elado_kiado = [[String : String]]()
    var adType = 0
    var order = 0
    var alertController = UIAlertController()
    var isShowingFavs : Int = 0
    var isJustMe : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerCellNib(DataTableViewCell.self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.openAddestate(_:)), name: "estate_adding", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.setShowingFavs(_:)), name: "setShowingFavs", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.setJustMe(_:)), name: "setJustMe", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.logout(_:)), name: "logout", object: nil)
        
        if (SettingUtil.sharedInstance.getToken() != "") {
            showLoadingDialog()
            LoginUtil.sharedInstance.getTokenValidator { (json: JSON) in
                print (json)
                var msg: Bool!
                msg = json["token_active"].boolValue
                if (msg == true) {
                    let userInfo: [String:AnyObject] = [ "userName": json["veznev"].stringValue + " " + json["kernev"].stringValue]
                    NSNotificationCenter.defaultCenter().postNotificationName("logged", object: userInfo)
                    //ImageHeaderView.sharedInstance.setName(json["veznev"].stringValue)
                    self.loadEstateList(0, page: 0, fav: self.isShowingFavs, etype: self.adType, ordering: self.order, justme: self.isJustMe)
                    self.tableView.addSubview(self.refreshControl)
                } else {
                    self.alertController.dismissViewControllerAnimated(true, completion: nil)
                    dispatch_async(dispatch_get_main_queue(),{
                        print ("TOKEN_INACTIVE_1")
                        self.alertController.dismissViewControllerAnimated(true, completion: nil)
                        SettingUtil.sharedInstance.setToken("")
                        if let navController = self.navigationController {
                            navController.popViewControllerAnimated(true)
                            self.loadRegistration()
                        }
                        
                        
                    })
                }
            }
        } else {
            print ("TOKEN_INACTIVE_2")
            self.alertController.dismissViewControllerAnimated(true, completion: nil)
            self.loadRegistration()
        }
        
        let createButton: (CGRect, LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton = { (frame, style) in
            let floatingActionButton = LiquidFloatingActionButton(frame: frame)
            floatingActionButton.animateStyle = style
            floatingActionButton.dataSource = self
            floatingActionButton.delegate = self
            floatingActionButton.isAddEstateButton = true
            //floatingActionButton.isPhoneButton = true
            //floatingActionButton.image = UIImage(named: "ic_action_heart")
            return floatingActionButton
        }
        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        let bottomRightButton = createButton(floatingFrame, .Up)
        self.view.addSubview(bottomRightButton)
    }
    
    func logout(notification: NSNotification) {
        LoginUtil.sharedInstance.doLogout({ (json: JSON) in
            print (json)
            dispatch_async(dispatch_get_main_queue(),{
                if (!json["error"].boolValue){
                    SettingUtil.sharedInstance.setToken("")
                    let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
                    let loginView = storyboard.instantiateViewControllerWithIdentifier("LoginView") as! LoginScreenViewController
                    self.navigationController?.pushViewController(loginView, animated: false)
                } else {
                    let alert = UIAlertController(title: "HIBA", message: "Sikertelen kijelentkezés", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        })
    }
    
    func setJustMe(notification: NSNotification) {
        isJustMe = 1
        isShowingFavs = 0
        self.items.removeAll()
        currentPage = 0
        showLoadingDialog()
        self.loadEstateList(0, page: 0, fav: self.isShowingFavs, etype: self.adType, ordering: self.order, justme: isJustMe)
    }
    
    func setShowingFavs(notification: NSNotification) {
        if let info = notification.object as? [String:AnyObject] {
            if let isFavs = info["isFavs"] as? String {
                if (isFavs == "1") {
                    isShowingFavs = 1
                } else {
                    isShowingFavs = 0
                }
            }
        }
        isJustMe = 0
        self.items.removeAll()
        currentPage = 0
        showLoadingDialog()
        self.loadEstateList(0, page: 0, fav: self.isShowingFavs, etype: self.adType, ordering: self.order, justme: isJustMe)
    }
    
    
    func showLoadingDialog() {
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: UIAlertControllerStyle.Alert)
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        spinnerIndicator.center = CGPointMake(135.0, 65.5)
        spinnerIndicator.color = UIColor.blackColor()
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.presentViewController(alertController, animated: false, completion: nil)
    }
    
    func pickImage () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func takePhoto () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        //imageView.image = image
        print ("IMAGE PICKED")
        
    }
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
    
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        print("did Tapped! \(index)")
        liquidFloatingActionButton.close()
    }
    
    func loadRegistration() {
        print ("Load Registration")
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let loginView = storyboard.instantiateViewControllerWithIdentifier("LoginView") as! LoginScreenViewController
        self.navigationController?.pushViewController(loginView, animated: false)
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MainViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.items.removeAll()
        currentPage = 0
        showLoadingDialog()
        self.loadEstateList(0, page: 0, fav: isShowingFavs, etype: self.adType, ordering: self.order, justme: isJustMe)
        
        refreshControl.endRefreshing()
    }
    
    
    @IBOutlet weak var ordering_text: UIButton!
    @IBAction func ordering(sender: AnyObject) {
        self.order += 1
        switch self.order {
        case 1:
            ordering_text.setTitle("Ár szerint növekvő", forState: UIControlState.Normal)
            break
        case 2:
            ordering_text.setTitle("Ár szerint csökkenő", forState: UIControlState.Normal)
            break
        default:
            ordering_text.setTitle("Dátum szerint", forState: UIControlState.Normal)
            self.order = 0
            break
        }
        self.items.removeAll()
        self.currentPage = 0
        showLoadingDialog()
        self.loadEstateList(0, page: 0, fav: isShowingFavs, etype: self.adType, ordering: self.order, justme: isJustMe)
    }
    
    @IBOutlet weak var elado_kiado_text: UIButton!
    @IBAction func elado_kiado(sender: AnyObject) {
        self.adType += 1
        switch self.adType {
        case 1:
            elado_kiado_text.setTitle("Eladó", forState: UIControlState.Normal)
            break
        case 2:
            elado_kiado_text.setTitle("Kiadoó", forState: UIControlState.Normal)
            break
        default:
            elado_kiado_text.setTitle("Mindegy", forState: UIControlState.Normal)
            self.adType = 0
            break
        }
        self.items.removeAll()
        self.currentPage = 0
        showLoadingDialog()
        self.loadEstateList(0, page: 0, fav: isShowingFavs, etype: self.adType, ordering: self.order, justme: isJustMe)
    }
    
    func loadEstateList(id: Int, page: Int, fav: Int, etype: Int, ordering: Int, justme: Int) {
        EstateUtil.sharedInstance.getEstateList(id, page: page, fav: fav, etype: etype, ordering: ordering, justme: justme, onCompletion: { (json: JSON) in
            print (json)
            if let results = json.array {
                for entry in results {
                    self.items.append(EstateListModel(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.alertController.dismissViewControllerAnimated(true, completion: nil)
                    if (results.count != 0) {
                        self.tableView.reloadData()
                    }
                })
            }
        })
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
    
    func openAddestate(notification: NSNotification) {
        let storyboard = UIStoryboard(name: "AddEstate", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("AddEstate_1") as! AddEstateViewController
        self.navigationController?.pushViewController(subContentsVC, animated: true)
        
        /*if let userInfo = notification.object as? [String:AnyObject] {
            if let loggedUserName = userInfo["userName"] as? String {
                print(loggedUserName)
                profileName.text = loggedUserName
            }
        }*/
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
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(DataTableViewCell.identifier) as! DataTableViewCell
        let data = DataTableViewCellData(id: items[indexPath.row].id,
                                         imageUrl: items[indexPath.row].pic,
                                         adress: String(items[indexPath.row].id),
                                         street: items[indexPath.row].street,
                                         description: items[indexPath.row].description,
                                         size: items[indexPath.row].size,
                                         rooms: items[indexPath.row].rooms,
                                         price: items[indexPath.row].price,
                                         e_type: items[indexPath.row].e_type,
                                         fav: items[indexPath.row].fav)
        cell.setData(data)
        
        if (largest_id < items[indexPath.row].id) {
            largest_id = items[indexPath.row].id
        }

        if (indexPath.row == self.items.count - 1) {
            print ("BOTTOM REACHED")
            currentPage += 1
            self.loadEstateList(largest_id, page: currentPage, fav: isShowingFavs, etype: self.adType, ordering: self.order, justme: isJustMe)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
        subContentsVC.id = items[indexPath.row].id
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
