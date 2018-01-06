//
//  DoSomeMapShiz.swift
//  Final
//
//  Created by Marcus Williams on 11/17/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import UIKit
import MapKit

class DoSomeMapShiz: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var address:String = ""
    var ClassName:String = ""
    var coords: CLLocationCoordinate2D?
    @IBOutlet weak var MyMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let geoCoder = CLGeocoder()
        let addressString = address
        geoCoder.geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                if error != nil {
                    print("Geocode failed with error: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    self.coords = location!.coordinate
                    self.showMap()
                }
                
            })
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle =  UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = address
        searchRequest.region = MyMap.region
        let request = MKLocalSearch(request: searchRequest)
        
        let activeSearch = request
        
        activeSearch.start {(response,error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("error")
            }
            else{
                
                let annotations = self.MyMap.annotations
                self.MyMap.removeAnnotations(annotations)
                for result in (response?.mapItems)!
                {
                    let latitude = result.placemark.coordinate.latitude
                    let longitude = result.placemark.coordinate.longitude
                    let annotation = MKPointAnnotation()
                    annotation.title = result.name
                    annotation.subtitle = "1"
                    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                    self.MyMap.addAnnotation(annotation)
                }
            }
        }
    }
    func showMap() {
        let center = CLLocationCoordinate2D(latitude: (coords?.latitude)!, longitude: (coords?.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        MyMap.setRegion(region, animated: true)
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.title = ClassName
        myAnnotation.subtitle = "1"
        let locationCoordinate = CLLocationCoordinate2DMake((coords?.latitude)!,(coords?.latitude)!)
         myAnnotation.coordinate = locationCoordinate
        self.MyMap.addAnnotation(myAnnotation)
        
        //mapItem.openInMaps(launchOptions: options)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
