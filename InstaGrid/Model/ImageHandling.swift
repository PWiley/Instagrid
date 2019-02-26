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
    
    
    var buttonsFrameArray = [#imageLiteral(resourceName: "Layout 1"), #imageLiteral(resourceName: "Layout 2.png"), #imageLiteral(resourceName: "Layout 3")]                     // declaration array buttonsFrameArray / initialised with the three different images
    var buttonsImageArray = [#imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape")]                 // declaration array buttonsImageArray / initialised with the three different images
    
    
    func inverseImage(startImage: Int ,endImage: Int) { // it manage the switch of the two images(First selected and the second)
        
        
        let firstImage = buttonsImageArray[startImage] // declaration of the firstImage set to the image from buttonsImagearray at the index startImage
        let lastImage = buttonsImageArray[endImage] // declaration of the lastImage set to the image from buttonsImageArray at the index lastImage
        
        buttonsImageArray[endImage] = firstImage // switch
        buttonsImageArray[startImage] = lastImage // switch
        
        
    }
}
