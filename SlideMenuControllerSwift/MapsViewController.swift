//
//  MapsViewController.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 12..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit
import MapKit
import FBAnnotationClusteringSwift
import SwiftyJSON

class MapsViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let numberOfLocations = 1000
    
    let clusteringManager = FBClusteringManager()
    
    var items = [EstateMapListModel]()
    
    
    var id_saved = ""
    var hsh_saved = ""
    
    var lat : Double = 0.0
    var lng : Double = 0.0
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UIBarButtonItem(image: UIImage.init(named: "ic_action_searchicon"), style: .Plain, target: self, action: #selector(openSearchMaps))
        
        navigationItem.rightBarButtonItem = search
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MapsViewController.openContentEstate), name: "openContentEstate", object: nil)
        
        getEstates()
    }
    
    func openSearchMaps() {
        print ("SEARCH MAP")
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = true
        searchController.active = true
        
        // Setup the Scope Bar
        //searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
    }
    
    func openContentEstate() {
        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
        subContentsVC.id = Int(id_saved)!
        subContentsVC.hsh = hsh_saved
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
    
    
    func goToLocation(latitude_: Double, longitude_: Double) {
        print ("GOTOLOCATION 1")
        if (latitude_ != 0.0 && longitude_ != 0.0) {
            print ("GOTOLOCATION 2")
            let latitude:CLLocationDegrees = latitude_
            let longitude:CLLocationDegrees = longitude_
            let latDelta:CLLocationDegrees = 0.015
            let lonDelta:CLLocationDegrees = 0.015
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            mapView.setRegion(region, animated: false)
        } else {
            print ("GOTOLOCATION 3")
            let latitude:CLLocationDegrees = 47.00
            let longitude:CLLocationDegrees = 20.00
            let latDelta:CLLocationDegrees = 7
            let lonDelta:CLLocationDegrees = 7
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomLocationsWithCount(count:Int) -> [FBAnnotation] {
        var array:[FBAnnotation] = []
        for _ in 0...count {
            let a:FBAnnotation = FBAnnotation()
            a.coordinate = CLLocationCoordinate2D(latitude: drand48() * 40 - 20, longitude: drand48() * 80 - 40 )
            array.append(a)
        }
        return array
    }
    
    func setCoordinates(item: [EstateMapListModel]) -> [FBAnnotation] {
        var array:[FBAnnotation] = []
        for i in 0...item.count-1 {
            let a:FBAnnotation = FBAnnotation()
            //a.coordinate = CLLocationCoordinate2D(latitude: drand48() * 40 - 20, longitude: drand48() * 80 - 40 )
            if (item[i].lat != 0.0 && item[i].lng != 0.0) {
                a.coordinate = CLLocationCoordinate2D(latitude: item[i].lat, longitude: item[i].lng)
                a.title = String(item[i].id)
                a.subtitle = item[i].hsh
                array.append(a)
            }
        }
        return array
    }
    
    
    func getEstates() {
        EstateUtil.sharedInstance.list_map_estates({ (json: JSON) in
                                                    print ("MAP ESTATES")
                                                    print (json)
                                                    if let results = json.array {
                                                        for entry in results {
                                                            self.items.append(EstateMapListModel(json: entry))
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(),{
                                                            //self.alertController.dismissViewControllerAnimated(true, completion: nil)
                                                            if (results.count != 0) {
                                                                //let array:[MKAnnotation] = self.randomLocationsWithCount(self.numberOfLocations)
                                                                let array:[MKAnnotation] = self.setCoordinates(self.items)
                                                                self.clusteringManager.addAnnotations(array)
                                                                self.clusteringManager.delegate = self;
                                                                self.goToLocation(self.lat, longitude_: self.lng)
                                                                //self.mapView.centerCoordinate = CLLocationCoordinate2DMake(0, 0);
                                                            }
                                                        })
                                                    }
        })
    }
    
    }

extension MapsViewController : FBClusteringManagerDelegate {
    
    func cellSizeFactorForCoordinator(coordinator:FBClusteringManager) -> CGFloat{
        return 1.0
    }
    
}


extension MapsViewController : MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool){
        
        NSOperationQueue().addOperationWithBlock({
            
            let mapBoundsWidth = Double(self.mapView.bounds.size.width)
            
            let mapRectWidth:Double = self.mapView.visibleMapRect.size.width
            
            let scale:Double = mapBoundsWidth / mapRectWidth
            
            let annotationArray = self.clusteringManager.clusteredAnnotationsWithinMapRect(self.mapView.visibleMapRect, withZoomScale:scale)
            
            self.clusteringManager.displayAnnotations(annotationArray, onMapView:self.mapView)
            
        })
        
    }

    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var reuseId : String
        
        if annotation.isKindOfClass(FBAnnotationCluster) {
            
            reuseId = "Cluster"
            var clusterView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            clusterView = FBAnnotationClusterView(annotation: annotation, reuseIdentifier: reuseId, options: nil)
            /*let options = FBAnnotationClusterViewOptions(smallClusterImage: "ic_action_house", mediumClusterImage: "ic_action_house", largeClusterImage: "ic_action_house")
            let clusterView = FBAnnotationClusterView(annotation: annotation, reuseIdentifier: reuseId, options: options)*/
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapsViewController.clusterTapped))
            clusterView!.addGestureRecognizer(tap)
            
            return clusterView
            
        } else {
            
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotation.title!!) as? MKPinAnnotationView
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.title!!)
            let tap: MyTapGestureRecognizer = MyTapGestureRecognizer(target: self, action: #selector(MapsViewController.pinTapped(_:)))
            tap.id = annotation.title!!
            tap.hsh = annotation.subtitle!!
            tap.pin = pinView
            pinView!.addGestureRecognizer(tap)
            
            
            //TESZT
            /*pinView!.canShowCallout = true
            let base = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 300))
            base.backgroundColor = UIColor.lightGrayColor()
            let label1 = UILabel(frame: CGRect(x: 30, y: 10, width: 60, height: 300))
            label1.textColor = UIColor.blackColor()
            label1.text = "00"
            base.addSubview(label1)
            pinView!.leftCalloutAccessoryView = base
            pinView!.pinColor = .Red*/
            //TESZT END
            

            
            //pinView!.pinTintColor = UIColor.greenColor()
            return pinView
        }
        
    }
    
    func pinTapped(sender: MyTapGestureRecognizer) {
        showPopOver(sender.pin!, id: sender.id!, hsh: sender.hsh!)
    }
    
    func clusterTapped() {
        print ("CLUSTER TAPPED")
        mapView.setZoomByDelta(0.6, animated: true)
    }

    
    func showPopOver(pin: MKPinAnnotationView, id: String, hsh: String) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("PopOver") as! MapsPopOverViewController
        vc.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 150)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        let popover = navController.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = pin
        self.id_saved = id
        self.hsh_saved = hsh
        vc.id = id
        vc.hsh = hsh
        self.presentViewController(navController, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return.None
    }

}

extension MKMapView {
    
    func setZoomByDelta(delta: Double, animated: Bool) {
        var _region = region;
        var _span = region.span;
        _span.latitudeDelta *= delta;
        _span.longitudeDelta *= delta;
        _region.span = _span;
        
        setRegion(_region, animated: animated)
    }
}

extension MapsViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension MapsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        //filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        let searchString = controller.searchBar.text
        //self.filterContentForSearchText(searchString, scope:searchOption)
        return true
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var id: String?
    var hsh: String?
    var pin: MKPinAnnotationView?
}



