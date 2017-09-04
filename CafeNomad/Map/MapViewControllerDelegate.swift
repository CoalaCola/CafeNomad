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
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.mapView = mapView
        selectedMarker = marker
        print(self.selectedMarker!)
        
        delegate?.addOneToTableView()
        
      
//         self.detailTextLabel.insert(marker.snippet!, at:0)
        
        
        for shop in shops {
            if shop.name == marker.title {
                  self.textLabel.insert(marker.title!, at:0)
                self.detailTextLabel.insert("Quiet:\(String(describing: shop.quiet!)) Food:\(String(describing: shop.tasty!)) Wifi:\(String(describing: shop.wifi!))", at:0)
                
                print(self.detailTextLabel)
                performSegue(withIdentifier: PropertyKeys.unwindToPlaces, sender: marker)
                print(textLabel)
        
            }
            
        }
        
        
        
        
       
        
       
        return false
    }
    
}
