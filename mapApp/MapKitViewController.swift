//
//  MapKitViewController.swift
//  mapApp
//
//  Created by リヴォーフ　ユーリ on 2019/12/17.
//  Copyright © 2019 リヴォーフ　ユーリ. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var placemark: CLPlacemark? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pin = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation))
        pin.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(pin)
        self.mapView.delegate = self
    }
    
    @objc func addAnnotation(gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: newCoordinates.latitude, longitude: newCoordinates.longitude), completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    print(placemarks!.count)
                    self.placemark = placemarks![0]
                    self.mapView.addAnnotation(annotation)
                }
                else {
                    annotation.title = "Unknown Place"
                    self.mapView.addAnnotation(annotation)
                    print("Problem with the data received from geocoder")
                }
            }
            )
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"

        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }

        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
            imageView.image = UIImage(named: "lovedeathrobots")git a
            annotationView.addSubview(imageView)
            
            let label = UILabel(frame: CGRect(x: 0, y: 10, width: 100, height: 30))
            label.textColor = .black
            label.adjustsFontSizeToFitWidth = true
            label.alpha = 0.8
            label.text = (placemark?.thoroughfare ?? "") + " " + (placemark?.subThoroughfare ?? "")
            annotationView.addSubview(label)
        }

        return annotationView
    }
}
