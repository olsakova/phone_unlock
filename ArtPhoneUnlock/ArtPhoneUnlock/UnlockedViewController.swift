//
//  UnlockedViewController.swift
//  ArtPhoneUnlock
//
//  Created by home on 2019-02-24.
//  Copyright © 2019 Andie Green-Harrison. All rights reserved.
//

import UIKit

class UnlockedViewController: UIViewController {
    var password = ""
    var picked = 0
    
    @IBOutlet weak var selection: UILabel!
    @IBOutlet weak var err: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func cancel(_ sender: Any) {
        reset()
    }
    @IBAction func submit(_ sender: Any) {
        if (self.password.count == 3){
            selection.text = "Successfully Changed Password"
            usr_password = self.password
            reset()
        }
        else{
            err.text = "Error: pick only 3 colors"
            selection.text = ""
            reset()
        }
        
    }
    func reset (){
        self.password = ""
        self.picked = 0
    }
    @IBAction func black(_ sender: Any) {
        if(picked < 3){
            self.password = self.password + "0"
            selection.text?.append(" Black ")
            picked+=1
        }
        
    }
    @IBAction func green(_ sender: Any) {
        
        if(picked < 3){
            self.password = self.password + "1"
            selection.text?.append(" Green ")
            picked+=1
        }
        
    }
    @IBAction func purple(_ sender: Any) {
        if(picked < 3){
            self.password = self.password + "2"
            selection.text?.append(" Purple ")
            picked+=1
        }
    }
    @IBAction func white(_ sender: Any) {
        if(picked < 3){
            self.password = self.password + "3"
            selection.text?.append(" White ")
            picked+=1
        }
    }
    @IBAction func yellow(_ sender: Any) {
        if(picked < 3){
            self.password = self.password + "4"
            selection.text?.append(" Yellow ")
            picked+=1
        }
    }
    @IBAction func red(_ sender: Any) {
        if(picked < 3){
            self.password = self.password + "5"
            selection.text?.append(" Red ")
            picked+=1
        }
    }
    @IBAction func orange(_ sender: Any) {
        if(picked < 3){
            self.password = self.password + "6"
            selection.text?.append(" Orange ")
            picked+=1
        }
    }
    @IBAction func blue(_ sender: Any) {
        if(picked < 3){
            self.password = self.password + "7"
            selection.text?.append(" Blue ")
            picked+=1
        }
    }
    
}
