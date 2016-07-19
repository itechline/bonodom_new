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
    var foglaltak = [IdopontokByDateModel]()
    var appointments = [IdopontokListaModel]()
    
    var id = 0
    var start = ""
    var finish = ""
    var hetfo = 0
    var kedd = 0
    var szerda = 0
    var csutortok = 0
    var pentek = 0
    var szombat = 0
    var vasarnap = 0
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var shouldShowDaysOut = false
    var animationFinished = true
    var dates: [NSDate] = []
    var selectedDay:DayView!
    var selectedDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerCellNib(CalendarItemViewController.self)
        
        let current_date = NSDate()
        presentedDateUpdated(CVDate.init(date: current_date))
        getIdoponts()
        
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BookingViewController.snackbar_reserved), name: "snackbar_reserved", object: nil)
    }
    
    func make_snackbar(msg: String) {
        NBMaterialSnackbar.showWithText(view, text: msg, duration: NBLunchDuration.SHORT)
    }
    
    func getIdoponts() {
        
        BookingUtil.sharedInstance.get_idoponts(id, onCompletion: { (json: JSON) in
            print ("BOOKING ID")
            print (String(self.id))
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
    
    func getIdoponts_2() {
        var starth = 0
        var startmin = 0
        var finh = 24
        var finmin = 0
        
        if(!start.isEmpty) {
            let startArr = start.characters.split{$0 == ":"}.map(String.init)
            print ("START HOUR", startArr[0])
            print ("START MIN", startArr[1])
            starth = Int(startArr[0])!
            startmin = Int(startArr[1])!
        }
        if(!finish.isEmpty) {
            let finishArr = finish.characters.split{$0 == ":"}.map(String.init)
            print ("FINISH HOUR", finishArr[0])
            print ("FINISH MIN", finishArr[1])
            finh = Int(finishArr[0])!
            finmin = Int(finishArr[1])!
        }
        
        for i in 0..<24 {
            for j in 0...1 {
                var j_: Int = 0
                if (j == 0) {
                    j_ = j
                } else {
                    j_ = 30
                }
                if(starth <= i && finh >= i) {
                    if ((starth == i && startmin <= j_) || starth != i) {
                        if ((finh == i && finmin >= j_) || finh != j_) {
                            self.appointments.append(IdopontokListaModel(h: i, m: j_, fogl: false))
                        }
                    }
                }
                
            }
        }
        
        for ii in 0..<foglaltak.count {
            let ttt = foglaltak[ii].datum.characters.split{$0 == ":"}.map(String.init)
            for jj in 0..<appointments.count {
                print ("APPOINTMENT MINUTES", String(appointments[jj].minutes))
                let minutesString = String(format: "%02d", appointments[jj].minutes)
                let hoursString = String(format: "%02d", appointments[jj].hours)
                if (ttt[1] == minutesString && ttt[0].substring(ttt[0].length-2) == hoursString) {
                    appointments[jj].foglalt = true
                }
            }
        }
        
        self.tableView.reloadData()
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
        //print("\(dayView.date.commonDescription) is selected!")
        print ("DAYVIEW", String(dayView.date.day))
        
        
        
        //KIOLVASVA A DÁTUM ROSZ 1 NAPPAL KEVESEBBET MUTAT ÍGY HOZZÁADOK EGYET, MAJD STRINGGÉ ALAKÍTOM ÉS KIVÁGOM AZ ELSŐ 10 KARAKTERT --> Paraszt megoldás :D
        let components: NSDateComponents = NSDateComponents()
        components.setValue(1, forComponent: NSCalendarUnit.Day);
        let date: NSDate = dayView.date.convertedDate()!
        let expirationDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))
        let asd = String(expirationDate!)
        let myNSString = asd as NSString
        let date_to_send = myNSString.substringWithRange(NSRange(location: 0, length: 10))
        print ("DATE SELECTED", date_to_send)
        selectedDate = date_to_send
        self.foglaltak.removeAll()
        self.appointments.removeAll()
        self.tableView.reloadData()
        
        BookingUtil.sharedInstance.get_idoponts_by_datum(id, datum: date_to_send, onCompletion: { (json: JSON) in
            print ("BOOKING BY DATE")
            print (json)
            
            if let results = json.array {
                for entry in results {
                    self.foglaltak.append(IdopontokByDateModel(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    //if (!foglaltak.isEmpty) {
                        //self.tableView.reloadData()
                        self.getIdoponts_2()
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
        
        //print ("DAYVIEW LABEL", String(dayView.weekdayIndex))
        //1: HÉTFŐ, 2:KEDD...
        if (dayView.weekdayIndex == 1 && hetfo == 1) {
            return true
        }
        
        if (dayView.weekdayIndex == 2 && kedd == 1) {
            return true
        }
        
        if (dayView.weekdayIndex == 3 && szerda == 1) {
            return true
        }
        
        if (dayView.weekdayIndex == 4 && csutortok == 1) {
            return true
        }
        
        if (dayView.weekdayIndex == 5 && pentek == 1) {
            return true
        }
        
        if (dayView.weekdayIndex == 6 && szombat == 1) {
            return true
        }
        
        if (dayView.weekdayIndex == 7 && hetfo == vasarnap) {
            return true
        }
        
        /*if (!dates.isEmpty) {
            for i in 0...dates.count-1 {
                if dayView.date.convertedDate()! == dates[i] {
                    return true
                } else {
                    
                }
            }
        }*/
        
        
        dayView.dayLabel.textColor = UIColor.lightGrayColor()
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

/*
 
 */

extension BookingViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CalendarItemViewController.height()
    }
}

extension BookingViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(CalendarItemViewController.identifier) as! CalendarItemViewController
        let data = CalendarItemViewDataCell(hours: appointments[indexPath.row].hours, minutes: appointments[indexPath.row].minutes, foglalt: appointments[indexPath.row].foglalt)
        
        cell.setData(data)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //FOGLALÁS MIKOR: 2016-07-20 09:30:00
        
        //let minutesString = String(format: "%02d", appointments[jj].minutes)
        if (appointments[indexPath.row].foglalt == false) {
            let mikor = selectedDate + " " + String(format: "%02d", appointments[indexPath.row].hours) + ":" + String(format: "%02d", appointments[indexPath.row].minutes) + ":00"
            print ("MIKOR", mikor)
            
            let alert = UIAlertController(title: "Figyelem", message: "Biztosan lefoglalja az alábbi időpontot?\r\n" + mikor, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Nem", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Igen", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("default")
                    BookingUtil.sharedInstance.add_idopont(mikor, ingatlan_id: self.id, onCompletion: { (json: JSON) in
                        print ("ADD IDOPONT")
                        print (json)
                        dispatch_async(dispatch_get_main_queue(),{
                            if (!json["error"].boolValue) {
                                print ("SIKERES FOGLALAS")
                                self.make_snackbar("Sikeres foglalás!")
                                self.appointments[indexPath.row].foglalt = true
                                self.tableView.reloadData()
                            } else {
                                self.make_snackbar("Sikertelen foglalás!")
                            }
                        })
                    })
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            
        } else {
            make_snackbar("Az időpont már foglalt!")
        }
        
        
        
        //print ("CELL TAPPED", String(appointments[indexPath.row].ingatlan_id))
        /*let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
        subContentsVC.id = items[indexPath.row].id
        subContentsVC.hsh = items[indexPath.row].hashString
        self.navigationController?.pushViewController(subContentsVC, animated: true)
 */
    }
}

