//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 23/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    var coordinate: CLLocationCoordinate2D?
    
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddLocationMapViewController {
            viewController.coordinate = coordinate
            viewController.mapString = locationTextField.text
            viewController.mediaURL = linkTextField.text
        }
    }
    

    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationPressed(_ sender: Any) {
        getGeocoder()
    }
    

}

// MARK: - Geocoder actions

extension AddLocationViewController {
    func getGeocoder() {
        
        guard let location = locationTextField.text else {
            // error
            return
        }
        
        guard let link = linkTextField.text else {
            // error
            return
        }
        
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                coordinate = location.coordinate
                performSegue(withIdentifier: "showPostLocation", sender: nil)
                print(coordinate)
            } else {
                // "No Matching Location Found"
            }
        }
    }
}
