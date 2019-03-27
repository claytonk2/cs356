//
//  FloatingActionButton.swift
//  Startup_App
//
//  Created by Benjamin Walter on 7/20/18.
//  Copyright © 2018 Clayton kingsbury. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButton {

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
            } else {
                self.transform = .identity
            }
        })
        return super.beginTracking(touch, with: event)
    }
}
