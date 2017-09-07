//
//  MapViewControllerDelegate.swift
//  CafeNomad
//
//  Created by Vince Lee on 2017/9/4.
//  Copyright © 2017年 Vince Lee. All rights reserved.
//

import Foundation
import GoogleMaps

extension MapViewController: GMSMapViewDelegate {
    
    // Tap the marker then
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        selectedMarker = marker
    // Find the shop information by checking through the array
        for shop in shops {
            if shop.name == marker.title {
                  self.textLabel.insert(marker.title!, at:0)
                self.detailTextLabel.insert("Quiet:\(String(describing: shop.quiet!)) 🍕:\(String(describing: shop.tasty!)) Wifi:\(String(describing: shop.wifi!))", at:0)
// send shop info to table view
                performSegue(withIdentifier: PropertyKeys.unwindToPlaces, sender: marker)
            }
        }
 // return true if you want to close the marker after tap
        return false
    }
    
}
