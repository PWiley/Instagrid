//
//  Extensions.swift
//  InstaGrid
//
//  Created by Patrick Wiley on 25.02.19.
//  Copyright © 2019 PawilIOS. All rights reserved.
//


import UIKit


extension UIView {
    
    
    // Create an image renderer
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    // MARK: Animation functions
    
    // method creates an animation fading for viewGeneral view
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    // method creates an animation to the up direction
    
    func viewGeneralSwipeUp() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.size.height * 2) }, completion : nil)
        
    }
    
    // method creates an animation to the left direction
    
    func viewGeneralSwipeLeft() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(translationX: -self.frame.size.width * 2, y: 0) }, completion : nil)
        
    }
}

