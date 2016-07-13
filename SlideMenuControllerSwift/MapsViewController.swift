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
        self.setNavigationBarItem()
        
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
        print ("SET COORDINATES")
        var array:[FBAnnotation] = []
        for i in 0...item.count-1 {
            print ("ADDING PIN")
            let a:FBAnnotation = FBAnnotation()
            //a.coordinate = CLLocationCoordinate2D(latitude: drand48() * 40 - 20, longitude: drand48() * 80 - 40 )
            if (item[i].lat != 0.0 && item[i].lng != 0.0) {
                print ("NOT ADDING PIN")
                a.coordinate = CLLocationCoordinate2D(latitude: item[i].lat, longitude: item[i].lng)
            }
            array.append(a)
        }
        return array
    }
    
    
    func getEstates() {
        EstateUtil.sharedInstance.list_map_estates({ (json: JSON) in
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
        
        var reuseId = ""
        
        if annotation.isKindOfClass(FBAnnotationCluster) {
            
            reuseId = "Cluster"
            var clusterView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            clusterView = FBAnnotationClusterView(annotation: annotation, reuseIdentifier: reuseId, options: nil)
            /*let options = FBAnnotationClusterViewOptions(smallClusterImage: "ic_action_house", mediumClusterImage: "ic_action_house", largeClusterImage: "ic_action_house")
            let clusterView = FBAnnotationClusterView(annotation: annotation, reuseIdentifier: reuseId, options: options)*/

            
            return clusterView
            
        } else {
            
            reuseId = "Pin"
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            
            //pinView!.pinTintColor = UIColor.greenColor()
            
            return pinView
        }
        
    }
    
}

