//
//  MapViewController.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewControllerProtocol:class {
    func refreshMapUI()
}


class MapViewController: UIViewController, MKMapViewDelegate, MapViewControllerProtocol {

    @IBOutlet weak var mapView: MKMapView!
    var mapViewModel: MapViewModel?

    override func  viewDidLoad() {
        
        super.viewDidLoad()
        //setting this class as mapView's delegate
        mapView.delegate = self
        //initializing the view model
        mapViewModel = MapViewModel(self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        refreshMapUI()
    }
    
    func refreshMapUI() {
        var annotations = [MKPointAnnotation]()
        if let result = mapViewModel?.getFeatures() {
                DispatchQueue.main.async {
                    for location in result.features {
                        //Here we are getting the latitude and longitude from our model and setting it to map annotation 
                        let long = CLLocationDegrees(location.geometry.coordinates[0])
                        let lat = CLLocationDegrees(location.geometry.coordinates[1])
                        let cords = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        

                        let annotation = MKPointAnnotation()
                        annotation.coordinate = cords
                        annotation.title = location.properties.title
                        annotation.subtitle = location.id
                        annotations.append(annotation)
                    }
                    // When the array is complete, we add the annotations to the map.
                    self.mapView.addAnnotations(annotations)
                }
            }
    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let detailsViewCtrl = DetailsViewController()
        self.navigationController?.pushViewController(detailsViewCtrl, animated: true)
        detailsViewCtrl.viewModel = DetailViewModel(feature:mapViewModel?.getFeatureWithId((view.annotation?.subtitle ?? "")!), detailViewCtrl: detailsViewCtrl)
    }
}
