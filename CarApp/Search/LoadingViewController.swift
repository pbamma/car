//
//  LoadingViewController.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import UIKit

class LoadingViewController: BaseViewController {
    @IBOutlet weak var fairView: UIView!
    @IBOutlet var dots: [UIImageView]!
    var dotIndex = 5
    let impact = UIImpactFeedbackGenerator()
    
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var constraintFairViewTop: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        if let lat = UserDefaults.standard.value(forKey: Constants.USER_DEFAULT_LATITUDE) as? Double, let long = UserDefaults.standard.value(forKey: Constants.USER_DEFAULT_LONGITUDE) as? Double {
            APIManager.sharedInstance.getCarSearchCircle(lat: lat, long: long, pickup: "2018-03-14", dropoff: "2018-03-19", radius: "25") { (data: CarData?, error: Error?) in
                //self.performSegue(withIdentifier: "sequeShowList", sender: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dotIndex = dots.count - 1
        doDotAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func doDotAnimation() {
        dots[dotIndex].alpha = 1
        impact.impactOccurred()
        if dotIndex != 0 {
            UIView.animate(withDuration: 0.25, animations: {
                self.dots[self.dotIndex].alpha = 0
            }) { (completed) in
                self.dotIndex -= 1
                self.doDotAnimation()
            }
        } else {
            drive(startAngle: 0, endAngle: -90, duration: 1.0)
        }
    }
    
    func drive(startAngle: CGFloat, endAngle: CGFloat, duration: TimeInterval) {
        let startRadian = Utils.degreesToRadians(degrees: startAngle)
        let endRadian = Utils.degreesToRadians(degrees: endAngle)
        
        self.fairView.transform = CGAffineTransform(rotationAngle: CGFloat(startRadian))
        self.constraintFairViewTop.constant = 0
        UIView.animate(withDuration: duration, delay: 1.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.fairView.transform = CGAffineTransform(rotationAngle: CGFloat(endRadian))
        }) { (completed) in
            self.constraintFairViewTop.constant = self.view.frame.size.height
            UIView.animate(withDuration: duration/1.5, delay: 0.2, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                self.performSegue(withIdentifier: "sequeToSearch", sender: self)
            }
        }
        
    }
}
