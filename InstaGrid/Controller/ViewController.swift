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
    
    
    
    
    let picker = UIImagePickerController()
    var imagesArray = [UIImage]()
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        //imagePicker.delegate = (self as! ImagePickerDelegate)
       
       
        
        buttonViewLargeTwo.imageView!.isHidden = true
        buttonViewTwoTwo.imageView!.isHidden = true
        buttonViewTwoLarge.imageView!.isHidden = false
        
       

        
    
        
     
       
       
        let buttonAdd1 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFill
        buttonAdd1.backgroundColor = .white
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
        
        
        
        let buttonAdd2 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
        

        let buttonAdd3 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        
        
//        stackViewTop.subviews.forEach { (item) in
//            item.removeFromSuperview()
//        }
       
        stackViewTop.addArrangedSubview(buttonAdd1)
        stackViewTop.addArrangedSubview(buttonAdd2)
        stackViewBottom.addArrangedSubview(buttonAdd3)
      


        
     
        
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
        
        
        let buttonAdd1 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
        
        let buttonAdd2 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
        
        let buttonAdd3 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        
        
        
        
        stackViewTop.addArrangedSubview(buttonAdd1)
        stackViewBottom.addArrangedSubview(buttonAdd2)
        stackViewBottom.addArrangedSubview(buttonAdd3)
    }
    
    @IBAction func showViewTwoLarge(_ sender: Any) {
        
        
        resetStackView() // call resetStackView method
        
        print("button 2")
        
        buttonViewLargeTwo.imageView!.isHidden = true
        buttonViewTwoLarge.imageView!.isHidden = false
        buttonViewTwoTwo.imageView!.isHidden = true
        
        
        
        let buttonAdd1 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
       
        
        let buttonAdd2 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
        
        
        let buttonAdd3 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        
        
        
        
        stackViewTop.addArrangedSubview(buttonAdd1)
        stackViewTop.addArrangedSubview(buttonAdd2)
        stackViewBottom.addArrangedSubview(buttonAdd3)
    }
    
    @IBAction func showViewTwoTwo(_ sender: Any) {
        
        resetStackView() // call resetStackView method
        
        print("button 3")
        
        buttonViewLargeTwo.imageView!.isHidden = true
        buttonViewTwoLarge.imageView!.isHidden = true
        buttonViewTwoTwo.imageView!.isHidden = false
        
        
        //let buttonAdd1 = UIButton(frame: CGRect(x: (viewWidth * 44 )/80, y: (viewHeight * 44)/80, width: buttonWidth, height: buttonWidth))
        let buttonAdd1 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
        
        let buttonAdd2 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
       
        
        let buttonAdd3 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        
        
        let buttonAdd4 = UIButton()
        buttonAdd1.imageView!.contentMode = .scaleAspectFit
        buttonAdd1.backgroundColor = .white
        buttonAdd4.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd4.addTarget(self, action: #selector(addImage4), for: .touchUpInside)
        
        
        //print("le nombre de vues est de : \(stackViewTop.arrangedSubviews.count)")
        
        
        //stackViewTop.addArrangedSubview(view1)
        stackViewTop.addArrangedSubview(buttonAdd1)
        stackViewTop.addArrangedSubview(buttonAdd2)
        stackViewBottom.addArrangedSubview(buttonAdd3)
        stackViewBottom.addArrangedSubview(buttonAdd4)
    }
    
  
    
    /*@objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage //2
        
        
        
        
        myImageView.contentMode = .scaleAspectFit //3
        myImageView1.image = chosenImage //4
        imagesArray.append(chosenImage)
        print(imagesArray.count)
        //print(myImageView)
        myImageView2.contentMode = .scaleAspectFit
        
        dismiss(animated:true, completion: nil) //5
    }*/
    
     func resetStackView() { // reset the stackView content to none
        
        stackViewTop.subviews.forEach { (item) in // remove the views from stackViewTop
            item.removeFromSuperview()
        }
        stackViewBottom.subviews.forEach { (item) in // remove the views from stackViewBottom
            item.removeFromSuperview()
        }
    }
    
}
    

