//
//  BookingViewController.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 15..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit
import CVCalendar
import SwiftyJSON
import NBMaterialDialogIOS

class BookingViewController: UIViewController {

    
    var items = [IdopontokModel]()
    var items_by_date = [IdopontokByDateModel]()
    var id = 0
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var shouldShowDaysOut = false
    var animationFinished = true
    var dates: [NSDate] = []
    var selectedDay:DayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerCellNib(CalendarItemViewController.self)
        
        let current_date = NSDate()
        presentedDateUpdated(CVDate.init(date: current_date))
        getIdoponts()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BookingViewController.snackbar_reserved), name: "snackbar_reserved", object: nil)
        
        
        
        
        
    }
    
    func snackbar_reserved() {
        print ("MAKING SNACKBAR")
        //NBMaterialSnackbar.showWithText(view, text: "Super awesome toast message, cheers!", duration: NBLunchDuration.LONG)
    }
    
    func getIdoponts() {
        BookingUtil.sharedInstance.get_idoponts(id, onCompletion: { (json: JSON) in
            print ("BOOKING")
            print (json)
            
            if let results = json.array {
                for entry in results {
                    self.items.append(IdopontokModel(json: entry))
                    print ("BOOKING ITEMS", self.items.count)
                }
                dispatch_async(dispatch_get_main_queue(),{
                    if (!self.items.isEmpty) {
                            for i in 0...self.items.count-1 {
                                let idopont = self.items[i].idopont
                                let dateFormatter = NSDateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                let date = dateFormatter.dateFromString(idopont)
                                self.dates.append(date!)
                            }
                        
                    }
                    self.menuView.commitMenuViewUpdate()
                    self.calendarView.commitCalendarViewUpdate()
                })
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print ("CALENDAR LOADED")
        //menuView.commitMenuViewUpdate()
        //calendarView.commitCalendarViewUpdate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BookingViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Monday
    }
    
    // MARK: Optional methods
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
        
        //KIOLVASVA A DÁTUM ROSZ 1 NAPPAL KEVESEBBET MUTAT ÍGY HOZZÁADOK EGYET, MAJD STRINGGÉ ALAKÍTOM ÉS KIVÁGOM AZ ELSŐ 10 KARAKTERT --> Paraszt megoldás :D
        let components: NSDateComponents = NSDateComponents()
        components.setValue(1, forComponent: NSCalendarUnit.Day);
        let date: NSDate = dayView.date.convertedDate()!
        let expirationDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))
        let asd = String(expirationDate!)
        let myNSString = asd as NSString
        let date_to_send = myNSString.substringWithRange(NSRange(location: 0, length: 10))
        print ("DATE SELECTED", date_to_send)
        self.items_by_date.removeAll()
        self.tableView.reloadData()
        
        BookingUtil.sharedInstance.get_idoponts_by_datum(id, datum: date_to_send, onCompletion: { (json: JSON) in
            print ("BOOKING BY DATE")
            print (json)
            
            
            if let results = json.array {
                for entry in results {
                    self.items_by_date.append(IdopontokByDateModel(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    //if (!self.items_by_date.isEmpty) {
                        self.tableView.reloadData()
                    //}
                })
            }
        })
        
        selectedDay = dayView
    }
    
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
            }) { _ in
                
                self.animationFinished = true
                self.monthLabel.frame = updatedMonthLabel.frame
                self.monthLabel.text = updatedMonthLabel.text
                self.monthLabel.transform = CGAffineTransformIdentity
                self.monthLabel.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        /*let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }*/
        if (!dates.isEmpty) {
            for i in 0...dates.count-1 {
                if dayView.date.convertedDate()! == dates[i] {
                    return true
                } else {
                    
                }
            }
        }
        
        
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        /*let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
            return [color, color, color]
        default:
            return [color] // return 1 dot
        }*/
        
        let color = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        return [color]
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 15
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRectMake(0, 0, $0.width, $0.height)) }
    }
    
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        let π = M_PI
        
        let ringSpacing: CGFloat = 3.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour: UIColor = .blueColor()
        
        let newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor
        
        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        /*if (Int(arc4random_uniform(3)) == 1) {
            return true
        }*/
        
        return false
    }
    
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    func dayOfWeekBackGroundColor() -> UIColor {
        return UIColor.orangeColor()
    }
}


// MARK: - CVCalendarViewAppearanceDelegate

extension BookingViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - IB Actions

extension BookingViewController {
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            calendarView.changeDaysOutShowingState(false)
            shouldShowDaysOut = true
        } else {
            calendarView.changeDaysOutShowingState(true)
            shouldShowDaysOut = false
        }
    }
    
    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
    }
    
    /// Switch to WeekView mode.
    @IBAction func toWeekView(sender: AnyObject) {
        calendarView.changeMode(.WeekView)
    }
    
    /// Switch to MonthView mode.
    @IBAction func toMonthView(sender: AnyObject) {
        calendarView.changeMode(.MonthView)
    }
    
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }
    
    
    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }
}

// MARK: - Convenience API Demo

extension BookingViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    func didShowNextMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month)")
    }
    
    
    func didShowPreviousMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month)")
    }
    
}

extension BookingViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CalendarItemViewController.height()
    }
}

extension BookingViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items_by_date.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(CalendarItemViewController.identifier) as! CalendarItemViewController
        let data = CalendarItemViewDataCell(id: items_by_date[indexPath.row].id, ingatlan_id: items_by_date[indexPath.row].ingatlan_id, datum: items_by_date[indexPath.row].datum, status: items_by_date[indexPath.row].status, fel_id: items_by_date[indexPath.row].fel_id)
        
        
        cell.setData(data)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print ("CELL TAPPED", String(items_by_date[indexPath.row].ingatlan_id))
        /*let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
        subContentsVC.id = items[indexPath.row].id
        subContentsVC.hsh = items[indexPath.row].hashString
        self.navigationController?.pushViewController(subContentsVC, animated: true)
 */
    }
}

