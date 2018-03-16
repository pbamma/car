//
//  SegueToSearch.swift
//  CarApp
//
//  Created by Philip Starner on 3/13/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//
import UIKit

class SegueToSearch: UIStoryboardSegue {
    
    override func perform() {
        if let src = self.source as? LoadingViewController, let dst = self.destination as? SearchViewController {
            
            let transition = CATransition()
            transition.duration = 0.6
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromBottom
            src.navigationController?.view.layer.add(transition, forKey: kCATransition)
            
            src.navigationController?.pushViewController(dst, animated: false)
        }
    }
}
