//
//  PlacesTableViewController.swift
//  CafeNomad
//
//  Created by Vince Lee on 2017/9/3.
//  Copyright © 2017年 Vince Lee. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class PlacesTableViewController: UITableViewController {
    
   
    
    
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    var selectedMarker: GMSMarker?
    var textLabel = [String]()
    var detailTextLabel = [String]()
    
    
    @IBAction func unwindToPlacesTVC(segue: UIStoryboardSegue) {
        let source = segue.source as? MapViewController
        if let textLabel = source?.textLabel, let detailTextLabel = source?.detailTextLabel {
            
            self.textLabel = textLabel
            self.detailTextLabel = detailTextLabel
            self.tableView.reloadData()
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

  

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return textLabel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.placesCell, for: indexPath)

        // Configure the cell...
        let textLabelItem = textLabel[indexPath.row]
        let detailTextLabelItem = detailTextLabel[indexPath.row]
        
        cell.textLabel?.text = textLabelItem
        cell.detailTextLabel?.text = detailTextLabelItem
        

        return cell
    }
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
