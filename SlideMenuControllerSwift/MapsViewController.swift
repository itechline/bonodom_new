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

class MapsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let numberOfLocations = 1000
    
    let clusteringManager = FBClusteringManager()
    
    var items = [EstateMapListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setNavigationBarItem()
        //self.navigationItem.leftBarButtonItem = nil
        
        /*let array:[MKAnnotation] = randomLocationsWithCount(numberOfLocations)
        
        clusteringManager.addAnnotations(array)
        clusteringManager.delegate = self;
        
        mapView.centerCoordinate = CLLocationCoordinate2DMake(0, 0);*/
        
        getEstates()
        
        
        // Do any additional setup after loading the view.
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
                                                                self.mapView.centerCoordinate = CLLocationCoordinate2DMake(0, 0);
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
            pinView!.addGestureRecognizer(tap)
            
            
            //TESZT
            pinView!.canShowCallout = true
            let base = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 300))
            base.backgroundColor = UIColor.lightGrayColor()
            let label1 = UILabel(frame: CGRect(x: 30, y: 10, width: 60, height: 300))
            label1.textColor = UIColor.blackColor()
            label1.text = "00"
            base.addSubview(label1)
            pinView!.leftCalloutAccessoryView = base
            pinView!.pinColor = .Red
            //TESZT END
            

            
            //pinView!.pinTintColor = UIColor.greenColor()
            return pinView
        }
        
    }
    
    func pinTapped(sender: MyTapGestureRecognizer) {
        print ("ID_A", sender.id!)
        print ("HASH", sender.hsh!)
        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
        subContentsVC.id = Int(sender.id!)!
        subContentsVC.hsh = sender.hsh!
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
    
    func clusterTapped() {
        print ("CLUSTER TAPPED")
    }

    
    
    
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var id: String?
    var hsh: String?
}

