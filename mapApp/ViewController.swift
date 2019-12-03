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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
          // Create a GMSCameraPosition that tells the map to display the
          // coordinate -33.86,151.20 at zoom level 6.
          let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
          let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
          view = mapView

          // Creates a marker in the center of the map.
          let marker = GMSMarker()
          marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
          marker.title = "Sydney"
          marker.snippet = "Australia"
          marker.map = mapView
    }
}

