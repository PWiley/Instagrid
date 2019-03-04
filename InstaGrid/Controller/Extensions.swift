//
//  Extensions.swift
//  InstaGrid
//
//  Created by Patrick Wiley on 25.02.19.
//  Copyright © 2019 PawilIOS. All rights reserved.
//


import UIKit


extension UIView {
    
    // method creates a animation fading
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    // Create an image renderer
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    // MARK: Animation functions
    func viewGeneralSwipeUp() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.size.height * 2) }, completion : nil)
        
    }
    
    func viewGeneralSwipeLeft() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(translationX: -self.frame.size.width * 2, y: 0) }, completion : nil)
        
    }
}

