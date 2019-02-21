//
//  ViewController.swift
//  ArtPhoneUnlock
//
//  Created by Andie Green-Harrison on 2019-02-19.
//  Copyright © 2019 Andie Green-Harrison. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (CLLocationManager.headingAvailable()) {
            locationManager.headingFilter = 1
            locationManager.startUpdatingHeading()
            locationManager.delegate = self
        }
    }
    @IBOutlet weak var paintBrushImage: UIImageView!
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //        print(newHeading.trueHeading)
        UIView.animate(withDuration: 0.1) {
            print(newHeading.trueHeading)
            let angle = newHeading.trueHeading * .pi / 180
            //            self.dialImage.transform = CGAffineTransform(rotationAngle: CGFloat(-angle))
            self.paintBrushImage.transform = CGAffineTransform(rotationAngle: CGFloat(-angle))
            
            
            //            self.arrowImage.transform = CGAffineTransform(translationX: CGFloat((cos(angle) * -100)), y: CGFloat(sin(angle)) * 100)
            
        }
    }
    

}

