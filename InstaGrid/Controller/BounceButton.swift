//
//  BounceButton.swift
//  InstaGrid
//
//  Created by Patrick Wiley on 19.02.19.
//  Copyright © 2019 PawilIOS. All rights reserved.
//

import UIKit

class BounceButton: UIButton { // declaration of BounceButton, inherited from UIButton

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // override the method from UIButton
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1) // add a scale effect
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: { // do animation during 0.5 second starting on the pression
            self.transform = CGAffineTransform.identity // get back to the initial characters of the button
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }

}
