//
//  ViewController.swift
//  ArtPhoneUnlock
//
//  Created by Andie Green-Harrison on 2019-02-19.
//  Copyright © 2019 Andie Green-Harrison. All rights reserved.
//

import UIKit
import CoreLocation
import AudioToolbox

var usr_password: String = ""

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var password = ""
    var pass_colors: [UIImageView] = []
    var currentPasswordAttempt = ""
    var currentColor = 0
    var colorsPicked: [UIImageView] = []
    var attempt = 0
    
    var done = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentPasswordAttempt = ""
        done = false
        colorsPicked.removeAll()
        switch usr_password {
        case "":
            password = "051"
            pass_colors.append(blackPaintImage)
            pass_colors.append(redPaintImage)
            pass_colors.append(greenPaintImage)
        default:
            password = usr_password
            setpass_colors (pass: usr_password)
        }
        
        if (CLLocationManager.headingAvailable()) {
            locationManager.headingFilter = 1
            locationManager.startUpdatingHeading()
            locationManager.delegate = self
        }
    }
    @IBOutlet weak var attempt_label: UILabel!
    @IBOutlet weak var paintBrushImage: UIImageView!
    @IBOutlet weak var bluePaintImage: UIImageView!
    @IBOutlet weak var blackPaintImage: UIImageView!
    @IBOutlet weak var greenPaintImage: UIImageView!
    @IBOutlet weak var yellowPaintImage: UIImageView!
    @IBOutlet weak var purplePaintImage: UIImageView!
    @IBOutlet weak var whitePaintImage: UIImageView!
    @IBOutlet weak var redPaintImage: UIImageView!
    @IBOutlet weak var orangePaintImage: UIImageView!
    
    func setpass_colors (pass: String){
        let colors = Array(pass)
        
        for color in colors {
            switch color{
            case "0":
                self.pass_colors.append(blackPaintImage)
            case "1":
                self.pass_colors.append(greenPaintImage)
            case "2":
                self.pass_colors.append(purplePaintImage)
            case "3":
                self.pass_colors.append(whitePaintImage)
            case "4":
                self.pass_colors.append(yellowPaintImage)
            case "5":
                self.pass_colors.append(redPaintImage)
            case "6":
                self.pass_colors.append(orangePaintImage)
            default:
                self.pass_colors.append(bluePaintImage)
            }
        }
        
        
    }

    func passwordEntered() {
        currentPasswordAttempt = ""
        
        switch colorsPicked {
        case [pass_colors[0], pass_colors[1], pass_colors[2]]:
            done = true
            self.performSegue(withIdentifier: "success", sender: self)
            print("Password Correct!")
        default:
            print("password failed ")
            print("password reset")
            attempt+=1
            attempt_label.text = "Failed Attempt " + String(attempt)
            
            self.view.layer.borderColor = UIColor.red.cgColor
            self.view.layer.borderWidth = 3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                self.view.layer.borderWidth = 0
            })
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            for paints in colorsPicked{
                paints.isHighlighted = false
            }
            colorsPicked.removeAll()
        }
        
    }
    
    func startColorTimer(colorNum: Int, paint: UIImageView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            if (colorNum == self.currentColor && !self.done) {
                print("Color chosen: \(colorNum)")
                self.currentPasswordAttempt.append(String(colorNum))
                
                self.colorsPicked.append(paint)
                
                UIView.animate(withDuration: 0.5, animations: {() -> Void in
                    paint.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }, completion: {(_ finished: Bool) -> Void in
                    UIView.animate(withDuration: 0.5, animations: {() -> Void in
                        paint.transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                })
                
                if (self.currentPasswordAttempt.count == 3) {
                    self.passwordEntered()
                }
            }
    
        })
    }
    func highlightPaint (currentPaint: UIImageView){
        blackPaintImage.isHighlighted = false
        bluePaintImage.isHighlighted = false
        greenPaintImage.isHighlighted = false
        yellowPaintImage.isHighlighted = false
        purplePaintImage.isHighlighted = false
        whitePaintImage.isHighlighted = false
        redPaintImage.isHighlighted = false
        orangePaintImage.isHighlighted = false
        
        for paint in self.colorsPicked{
            paint.isHighlighted = true
        }
        currentPaint.isHighlighted = true
        
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
                    self.highlightPaint(currentPaint: self.bluePaintImage)
                    self.startColorTimer(colorNum: 7, paint: self.bluePaintImage)
                }
//                print("Blue")
            case 65..<110:
                if (self.currentColor != 6) {
                    self.currentColor = 6
                    self.highlightPaint(currentPaint: self.orangePaintImage)
                    self.startColorTimer(colorNum: 6, paint: self.orangePaintImage)
                }
//                print("Orange")
            case 110..<155:
                if (self.currentColor != 5) {
                    self.currentColor = 5
                    self.highlightPaint(currentPaint: self.redPaintImage)
                    self.startColorTimer(colorNum: 5, paint: self.redPaintImage)
                }
//                print("Red")
            case 155..<200:
                if (self.currentColor != 4) {
                    self.currentColor = 4
                    self.highlightPaint(currentPaint: self.yellowPaintImage)
                    self.startColorTimer(colorNum: 4, paint: self.yellowPaintImage)
                }
//                print("Yellow")
            case 200..<245:
                if (self.currentColor != 3) {
                    self.currentColor = 3
                    self.highlightPaint(currentPaint: self.whitePaintImage)
                    self.startColorTimer(colorNum: 3, paint: self.whitePaintImage)
                }
//                print("White")
            case 245..<290:
                if (self.currentColor != 2) {
                    self.currentColor = 2
                    self.highlightPaint(currentPaint: self.purplePaintImage)
                    self.startColorTimer(colorNum: 2, paint: self.purplePaintImage)
                }
//                print("Purple")
            case 290..<335:
                if (self.currentColor != 1) {
                    self.currentColor = 1
                    self.highlightPaint(currentPaint: self.greenPaintImage)
                    self.startColorTimer(colorNum: 1, paint: self.greenPaintImage)
                }
//                print("Green")
            default:
                if (self.currentColor != 0) {
                    self.currentColor = 0
                    self.highlightPaint(currentPaint: self.blackPaintImage)
                    self.startColorTimer(colorNum: 0, paint: self.blackPaintImage)
                }
//                print("Black")

            }
            
            
//            Timed function, timed function cancel
            
            
            //            self.arrowImage.transform = CGAffineTransform(translationX: CGFloat((cos(angle) * -100)), y: CGFloat(sin(angle)) * 100)
            
        }
    }
    

}

