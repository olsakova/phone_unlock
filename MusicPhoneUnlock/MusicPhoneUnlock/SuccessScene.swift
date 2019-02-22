//
//  SuccessScene.swift
//  MusicPhoneUnlock
//
//  Created by Michaela on 2019-02-21.
//  Copyright © 2019 HCI581. All rights reserved.
//

import Foundation
import SpriteKit

class SuccessScene: SKScene {
    override func didMove(to view: SKView) {
        //self.backgroundColor = UIColor(patternImage: UIImageView(named: "Success"))
        
        let background = UIImage(named: "Success3")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
