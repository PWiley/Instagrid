//
//  ViewGeneral.swift
//  InstaGrid
//
//  Created by Patrick Wiley on 05.01.19.
//  Copyright © 2019 PawilIOS. All rights reserved.
//

import UIKit

class ViewGeneral: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    enum Style {
        case ViewLargeTwo, ViewTwoLarge, ViewTwoTwo
    }
    
    var style: Style = .ViewTwoLarge {
        didSet {
            setStyle(style)
        }
    }
    
    private func setStyle(_ style: Style) {
        switch style {
        case .ViewLargeTwo:
            backgroundColor = .white
            
            
        case .ViewTwoLarge:
            backgroundColor = .white
            
        case .ViewTwoTwo:
            backgroundColor = .white
            
        }
    }
    
    @IBOutlet private var label: UILabel!
    @IBOutlet private var icon: UIImageView!

}
