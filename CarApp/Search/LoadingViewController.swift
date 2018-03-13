//
//  LoadingViewController.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import UIKit

class LoadingViewController: BaseViewController {
    var imageBackgroundView: UIImageView?
//    var blurContainer: UIView?
//    var blurContainerEffectView: UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupBackground() {
        let rect = CGRect(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT)
        //add blur to container
        if self.imageBackgroundView == nil {
            self.imageBackgroundView = UIImageView(frame: rect)
            self.imageBackgroundView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.imageBackgroundView?.image = UIImage(named: "background")
            self.imageBackgroundView?.contentMode = .scaleAspectFill
            self.imageBackgroundView?.layer.masksToBounds = true
            self.view.insertSubview(self.imageBackgroundView!, at: 0)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
