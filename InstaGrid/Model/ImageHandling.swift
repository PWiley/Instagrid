//
//  Image.swift
//  InstaGrid
//
//  Created by Patrick Wiley on 24.02.19.
//  Copyright © 2019 PawilIOS. All rights reserved.
//

import Foundation
import UIKit


class ImageHandling{
    
    
    var buttonsImageArray = [#imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape")]
    
    var image: UIImage {
        willSet {
            
            print("We will set the image in the array")
            print(buttonsImageArray[0])
        }
        didSet{
            buttonsImageArray[0] = image
            print("The image was updated in the array")
            print(buttonsImageArray[0])
            
        }
    }
    init() {
        image = #imageLiteral(resourceName: "Combined Shape")
    }
}
