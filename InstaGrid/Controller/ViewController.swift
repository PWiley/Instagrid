//
//  ViewController.swift
//  InstaGrid
//
//  Created by Patrick Wiley on 13.12.18.
//  Copyright © 2018 PawilIOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shareChoice: UIImageView!
    @IBOutlet weak var imageArrow: UIImageView!
    
    @IBOutlet weak var stackViewTop: UIStackView!
    @IBOutlet weak var stackViewBottom: UIStackView!
    
    @IBOutlet weak var buttonViewLargeTwo: UIButton!
    @IBOutlet weak var buttonViewTwoLarge: UIButton!
    @IBOutlet weak var buttonViewTwoTwo: UIButton!
    
    public var screenWidth: CGFloat = UIScreen.main.bounds.size.width
    public var screenHeight: CGFloat = UIScreen.main.bounds.size.height
    public var viewWidth: CGFloat = 0
    public var viewHeight: CGFloat = 0
    public var buttonWidth: CGFloat = 0
    
    fileprivate var imagePicker = ImagePicker()
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        buttonViewLargeTwo.imageView!.isHidden = true
        buttonViewTwoTwo.imageView!.isHidden = true
        buttonViewTwoLarge.imageView!.isHidden = false
        
        viewWidth = (screenWidth * 80) / 375
        viewHeight = (screenHeight * 80) / 667
        buttonWidth = (screenWidth * 40) / 375
        
        
        print(viewWidth)
        print(viewHeight)
        
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()

        view1.backgroundColor = .white
        view2.backgroundColor = .white
        view3.backgroundColor = .white
        view4.backgroundColor = .white
        
    
        
        //print(UIScreen.main.bounds.size.width)
        //print(UIScreen.main.bounds.size.height)
       
       
        let buttonAdd1 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
        view1.addSubview(buttonAdd1)
        
        
        let buttonAdd2 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
        view2.addSubview(buttonAdd2)

        let buttonAdd3 = UIButton(frame: CGRect(x: (viewWidth * 115 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        view3.addSubview(buttonAdd3)
        
//        stackViewTop.subviews.forEach { (item) in
//            item.removeFromSuperview()
//        }
       
        stackViewTop.addArrangedSubview(view1)
        stackViewTop.addArrangedSubview(view2)
        stackViewBottom.addArrangedSubview(view3)
      


        
     
        
    }
    fileprivate func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.controller.sourceType = sourceType
        DispatchQueue.main.async {
            self.present(self.imagePicker.controller, animated: true, completion: nil)
        }
    }
    @objc func addImage1(sender: UIButton!) { // add image in position 1
        print("Button 1 tapped")
        
        
    }
    @objc func addImage2(sender: UIButton!) { // add image in position 2
        print("Button 2 tapped")
    
    }
    @objc func addImage3(sender: UIButton!) { // add image in position 3
        print("Button 3 tapped")
        
    }
    @objc func addImage4(sender: UIButton!) { // add image in position 4
        print("Button 4 tapped")
        
    }
    

    @IBAction func showViewLargeTwo(_ sender: Any) {
        
        print("button 1")
        
        resetStackView() // call resetStackView method
        
       buttonViewLargeTwo.imageView!.isHidden = false
       buttonViewTwoLarge.imageView!.isHidden = true
       buttonViewTwoTwo.imageView!.isHidden = true
        
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()
        
        view1.backgroundColor = .white
        view2.backgroundColor = .white
        view3.backgroundColor = .white
        view4.backgroundColor = .white
        
        let buttonAdd1 = UIButton(frame: CGRect(x: (viewWidth * 115 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
        view1.addSubview(buttonAdd1)
        
        let buttonAdd2 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
        view2.addSubview(buttonAdd2)
        
        let buttonAdd3 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        view3.addSubview(buttonAdd3)
        
        
        
        stackViewTop.addArrangedSubview(view1)
        stackViewBottom.addArrangedSubview(view2)
        stackViewBottom.addArrangedSubview(view3)
        
    }
    
    @IBAction func showViewTwoLarge(_ sender: Any) {
        
       resetStackView() // call resetStackView method
        
        print("button 2")
        
       buttonViewLargeTwo.imageView!.isHidden = true
       buttonViewTwoLarge.imageView!.isHidden = false
       buttonViewTwoTwo.imageView!.isHidden = true
        
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()
        
        view1.backgroundColor = .white
        view2.backgroundColor = .white
        view3.backgroundColor = .white
        view4.backgroundColor = .white
        
        let buttonAdd1 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
        view1.addSubview(buttonAdd1)
        
        let buttonAdd2 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
        view2.addSubview(buttonAdd2)
        
        let buttonAdd3 = UIButton(frame: CGRect(x: (viewWidth * 115 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        view3.addSubview(buttonAdd3)
        
        
        
        stackViewTop.addArrangedSubview(view1)
        stackViewTop.addArrangedSubview(view2)
        stackViewBottom.addArrangedSubview(view3)
    }
   
    @IBAction func showViewTwoTwo(_ sender: Any) {
        
        resetStackView() // call resetStackView method
        
        print("button 3")
        
       buttonViewLargeTwo.imageView!.isHidden = true
       buttonViewTwoLarge.imageView!.isHidden = true
       buttonViewTwoTwo.imageView!.isHidden = false
        
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()
        
        view1.backgroundColor = .white
        view2.backgroundColor = .white
        view3.backgroundColor = .white
        view4.backgroundColor = .white
        
        let buttonAdd1 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
        view1.addSubview(buttonAdd1)
        
        let buttonAdd2 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
        view2.addSubview(buttonAdd2)
        
        let buttonAdd3 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        view3.addSubview(buttonAdd3)
        
        let buttonAdd4 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        buttonAdd4.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd4.addTarget(self, action: #selector(addImage4), for: .touchUpInside)
        view4.addSubview(buttonAdd4)
        
        //print("le nombre de vues est de : \(stackViewTop.arrangedSubviews.count)")
       
        
        stackViewTop.addArrangedSubview(view1)
        stackViewTop.addArrangedSubview(view2)
        stackViewBottom.addArrangedSubview(view3)
        stackViewBottom.addArrangedSubview(view4)
    }
    
    func resetStackView() { // reset the stackView content to none
        
        stackViewTop.subviews.forEach { (item) in // remove the views from stackViewTop
            item.removeFromSuperview()
        }
        stackViewBottom.subviews.forEach { (item) in // remove the views from stackViewBottom
            item.removeFromSuperview()
        }
    }
    
}
    
extension ViewController: ImagePickerDelegate {
    
    func imagePickerDelegate(didSelect image: UIImage, imageName:String, delegatedForm: ImagePicker) {
        imageView.image = image
        imagePicker.dismiss()
    }
    
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
        imagePicker.dismiss()
    }
    
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed {
            presentImagePicker(sourceType: .photoLibrary)
        }
    }
    
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed {
            // works only on real device (crash on simulator)
            presentImagePicker(sourceType: .camera)
        }
    }
}
