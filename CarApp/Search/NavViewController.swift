//
//  NavViewController.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        viewController.title = "Loading..."
        self.pushViewController(viewController, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        downloadVehicleList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadVehicleList() {
//        APIManager.sharedInstance.testRetrieveLocalVehicleList { (vehicleList: VehicleList?, error: NSError?) in
//            if let vList = vehicleList {
//                self.vehicleList = vList
//                self.performSegue(withIdentifier: "sequeShowList", sender: self)
//            } else {
//                print("Error getting vehicle list: \(error?.description)")
//            }
//        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sequeShowList" {
            // inject search VC with dependency (sort of dependency... we're not doing it via initialization, but it will crash if not injected here.)
            let viewController = segue.destination as! SearchViewController
            
        }
    }

}
