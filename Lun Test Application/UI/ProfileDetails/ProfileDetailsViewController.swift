//
//    ProfileDetailsViewController.swift 
//    Lun Test Application
//
//    Created by Oleg Lipskiy on 3/13/19
//    Copyright © 2019 Oleg Lipskiy. All rights reserved.

    

import Foundation
import UIKit
import GoogleMaps

class ProfileDetailsViewController: UIViewController {
    var profile: Profile!
    
    @IBOutlet weak var mapView: GMSMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = profile.name
        
        setupCamera()
        setupMarker()
        
    }
    
    private func setupCamera() {
        let camera = GMSCameraPosition.camera(withLatitude: profile.lat, longitude: profile.lng, zoom: 15.0)
        mapView.animate(to: camera)
    }
    
    private func setupMarker() {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: profile.lat, longitude: profile.lng)
        marker.title = "\(profile.name)'s location"
        marker.snippet = profile.address
        marker.map = mapView
    }
    
}
