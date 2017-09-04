//
//  MapViewController.swift
//  CafeNomad
//
//  Created by Vince Lee on 2017/9/3.
//  Copyright © 2017年 Vince Lee. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
import CoreLocation


class MapViewController: UIViewController {
    
    @IBOutlet weak var upperMapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    var selectedMarker: GMSMarker?
    var selectedShop: Shop?
    var textLabel = [String]()
    var detailTextLabel = [String]()
    weak var delegate: ShopDelagate?
    
    var shops = [Shop]()
    var markers = [GMSMarker]()
    let defaultLocation = CLLocation(latitude: 25.039654, longitude: 121.549747)
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        
        
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.compassButton = true
    
        mapView.settings.setAllGesturesEnabled(true)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        view = mapView
        mapView.isHidden = true
        mapView.delegate = self
        ShopController.shared.fetchShop { (shops) in
            if let shops = shops {
                
                DispatchQueue.main.async {
                    self.createMarkers(shops: shops)
                }
            }
            // Do any additional setup after loading the view.
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Populate the array with the list of likely places.
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                }
            }
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func createMarkers(shops: [Shop]) {
        
        for shop in shops {
            let marker = GMSMarker()
            if let latitude = Double(shop.latitude!), let longitude = Double(shop.longitude!) {
                
                marker.position = CLLocationCoordinate2D(latitude:latitude , longitude: longitude)
            }
            marker.title = shop.name
            marker.snippet = shop.open_time
            
            marker.map = self.mapView
            self.shops.append(shop)
        }
        print(GMSPath.count)
    }
    
   
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        listLikelyPlaces()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
