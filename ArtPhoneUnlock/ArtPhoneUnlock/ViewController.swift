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
    let password = "051"
    var currentPasswordAttempt = ""
    var currentColor = 0
    
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
    @IBOutlet weak var bluePaintImage: UIImageView!
    @IBOutlet weak var blackPaintImage: UIImageView!
    @IBOutlet weak var greenPaintImage: UIImageView!
    @IBOutlet weak var yellowPaintImage: UIImageView!
    
    
    func printSuccess() {
        print("Success")
    }
    
    func passwordEntered() {
        if (self.password.elementsEqual(self.currentPasswordAttempt)) {
            print("Password Correct!")
        } else {
            print("password failed")
            
        }
        currentPasswordAttempt = ""
        print("password reset")
    }
    
    func startColorTimer(colorNum: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            if (colorNum == self.currentColor) {
                print("Color chosen: \(colorNum)")
                self.currentPasswordAttempt.append(String(colorNum))
                
                if (self.currentPasswordAttempt.count == self.password.count) {
                    self.passwordEntered()
                }
            }
    
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {

        //        print(newHeading.trueHeading)
        UIView.animate(withDuration: 0.1) {
//            print(Int(newHeading.trueHeading))
            let angle = newHeading.trueHeading * .pi / 180
            //            self.dialImage.transform = CGAffineTransform(rotationAngle: CGFloat(-angle))
            self.paintBrushImage.transform = CGAffineTransform(rotationAngle: CGFloat(-angle))
            switch Int(newHeading.trueHeading) {
            case 20..<65:
                if (self.currentColor != 7) {
                    self.currentColor = 7
                    self.startColorTimer(colorNum: 7)
                }
//                print("Blue")
            case 65..<110:
                if (self.currentColor != 6) {
                    self.currentColor = 6
                    self.startColorTimer(colorNum: 6)
                }
//                print("Orange")
            case 110..<155:
                if (self.currentColor != 5) {
                    self.currentColor = 5
                    self.startColorTimer(colorNum: 5)
                }
//                print("Red")
            case 155..<200:
                if (self.currentColor != 4) {
                    self.currentColor = 4
                    self.startColorTimer(colorNum: 4)
                }
//                print("Yellow")
            case 200..<245:
                if (self.currentColor != 3) {
                    self.currentColor = 3
                    self.startColorTimer(colorNum: 3)
                }
//                print("White")
            case 245..<290:
                if (self.currentColor != 2) {
                    self.currentColor = 2
                    self.startColorTimer(colorNum: 2)
                }
//                print("Purple")
            case 290..<330:
                if (self.currentColor != 1) {
                    self.currentColor = 1
                    self.startColorTimer(colorNum: 1)
                }
//                print("Green")
            default:
                if (self.currentColor != 0) {
                    self.currentColor = 0
                    self.startColorTimer(colorNum: 0)
                }
//                print("Black")

            }
            
            
//            Timed function, timed function cancel
            
            
            //            self.arrowImage.transform = CGAffineTransform(translationX: CGFloat((cos(angle) * -100)), y: CGFloat(sin(angle)) * 100)
            
        }
    }
    

}

