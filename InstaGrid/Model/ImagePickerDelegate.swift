//
//  ImagePickerDElegate.swift
//  InstaGrid
//
//  Created by Patrick Wiley on 09.01.19.
//  Copyright © 2019 PawilIOS. All rights reserved.
//

import UIKit

protocol ImagePickerDelegate {
    //func imagePickerDelegate(canUseCamera accessIsAllowed:Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(canUseGallery accessIsAllowed:Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(didSelect image: UIImage, imageName:String, delegatedForm: ImagePicker)
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker)
}

extension ImagePickerDelegate {
    func imagePickerDelegate(canUseCamera accessIsAllowed:Bool, delegatedForm: ImagePicker) {}
    func imagePickerDelegate(canUseGallery accessIsAllowed:Bool, delegatedForm: ImagePicker) {}
}
