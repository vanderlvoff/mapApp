//
//  ViewController.swift
//  mapApp
//
//  Created by リヴォーフ　ユーリ on 2019/12/03.
//  Copyright © 2019 リヴォーフ　ユーリ. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var myMapUIView: UIView!

    var camera: GMSCameraPosition = GMSCameraPosition()
    var mapView: GMSMapView = GMSMapView()

    var places: [String: [Double]] = ["Moscow": [55.75, 37.61], "London": [51.50, 0.12], "New York": [40.71, -74.00]]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

          // Create a GMSCameraPosition that tells the map to display the
          // coordinate -33.86,151.20 at zoom level 6.
        camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: self.myMapUIView.bounds, camera: camera)

          // Creates a marker in the center of the map.
          let marker = GMSMarker()
          marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
          marker.title = "Sydney"
          marker.snippet = "Australia"
          marker.map = mapView

        self.myMapUIView.addSubview(mapView)
    }
    @IBAction func findCity(_ sender: Any) {

        placeName.resignFirstResponder()
        let placeKey = placeName.text ?? "London"
        let placeCoords = self.places[placeKey]
        let location = GMSCameraPosition.camera(withLatitude: (placeCoords?[0])!, longitude: (placeCoords?[1])!, zoom: 6.0)

        mapView.camera = location

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (placeCoords?[0])!, longitude: (placeCoords?[1])!)
        marker.title = placeKey
        marker.map = mapView
    }
}

