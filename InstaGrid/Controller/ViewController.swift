//
//  ViewController.swift
//  InstaGrid
//
//  Created by Patrick Wiley on 13.12.18.
//  Copyright © 2018 PawilIOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var shareChoice: UIImageView!
    @IBOutlet weak var imageArrow: UIImageView!
    
    @IBOutlet weak var stackViewTop: UIStackView!
    @IBOutlet weak var stackViewBottom: UIStackView!
    
    
    @IBOutlet weak var buttonViewLargeTwo: UIButton!
    
    
    @IBOutlet weak var buttonViewTwoLarge: UIButton!
    
    
    @IBOutlet weak var buttonViewTwoTwo: UIButton!
    
    
    
    
    let picker = UIImagePickerController()
    
    var buttonsArray = [UIButton]()
    var currentTag: Int = 0
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        picker.delegate = self
        
        createButtons() // creates the four buttons so they can by added later in the two different stackView
        // stackViewTop will contain maximum two
        // stackViewBottom will contain maximum two
        // it will depend on the type of the frame shown
        
        
        buttonViewLargeTwo.imageView!.isHidden = true // displays the buttonViewLargeTwo checked image
        buttonViewTwoTwo.imageView!.isHidden = true // displays the buttonViewLargeTwo checked image
        buttonViewTwoLarge.imageView!.isHidden = false // displays the buttonViewLargeTwo checked image
        stackViewTop.addArrangedSubview(buttonsArray[0]) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(buttonsArray[1]) // adds the button to the stackViewTop in position Two
        stackViewBottom.addArrangedSubview(buttonsArray[2]) // adds the button to the stackViewBottom in position Three
        
        
        
    }
    //Mark: - Display
    
    @IBAction func showViewLargeTwo(_ sender: Any) {
        
        resetStackView() // call resetStackView method
        buttonViewLargeTwo.imageView!.isHidden = false // displays the buttonViewLargeTwo checked image
        buttonViewTwoLarge.imageView!.isHidden = true // hiddes the buttonViewTwoLarge checked image
        buttonViewTwoTwo.imageView!.isHidden = true // hiddes the buttonViewTwoTwo checked image
        stackViewTop.addArrangedSubview(buttonsArray[0]) // adds the button to the stackViewTop in position One
        stackViewBottom.addArrangedSubview(buttonsArray[1]) // adds the button to the stackViewBottom in position three
        stackViewBottom.addArrangedSubview(buttonsArray[2]) // adds the button to the stackViewBottom in position four
    }
    
    @IBAction func showViewTwoLarge(_ sender: Any) { // displays the view ViewTwoLarge
        
        resetStackView() // call resetStackView method
        buttonViewLargeTwo.imageView!.isHidden = true // hiddes the buttonViewLargeTwo checked image
        buttonViewTwoLarge.imageView!.isHidden = false // displays the buttonViewTwoLarge checked image
        buttonViewTwoTwo.imageView!.isHidden = true // hiddes the buttonViewTwoTwo checked image
        stackViewTop.addArrangedSubview(buttonsArray[0]) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(buttonsArray[1]) // adds the button to the stackViewTop in position Two
        stackViewBottom.addArrangedSubview(buttonsArray[2]) // adds the button to the stackViewTop in position Three
    }
    
    @IBAction func showViewTwoTwo(_ sender: Any) {
        
        resetStackView() // call resetStackView method
        buttonViewLargeTwo.imageView!.isHidden = true // hiddes the buttonViewLargeTwo checked image
        buttonViewTwoLarge.imageView!.isHidden = true // hiddes the buttonViewTwoLarge checked image
        buttonViewTwoTwo.imageView!.isHidden = false // displays the buttonViewTwoTwo checked image
        stackViewTop.addArrangedSubview(buttonsArray[0]) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(buttonsArray[1]) // adds the button to the stackViewTop in position One
        stackViewBottom.addArrangedSubview(buttonsArray[2]) // adds the button to the stackViewBottom in position Three
        stackViewBottom.addArrangedSubview(buttonsArray[3]) // adds the button to the stackViewBottom in position Four
    }
    
    //Mark: - Actions
    
    @objc func buttonAddImagePressed(sender: UIButton!) { // add image in position 1
        
        picker.allowsEditing = false // allows not the editing access to the picker
        picker.sourceType = .photoLibrary // declares the type of the source
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
        
        if sender.tag == 1 {
            currentTag = sender.tag // sets currentTag to the sender.tag
        }
        if sender.tag == 2 {
         
            currentTag = sender.tag
        }
        if sender.tag == 3 {
         
            currentTag = sender.tag
        }
        if sender.tag == 4 {
           
            currentTag = sender.tag
            
        }
    }
    
    
    
    
    
    //MARK: - Delegates
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if currentTag == 0 {
                buttonsArray[0].setImage(chosenImage, for: .normal)
                
            }
            if currentTag == 1 {
                buttonsArray[1].setImage(chosenImage, for: .normal)
                
            }
            if currentTag == 2 {
                buttonsArray[2].setImage(chosenImage, for: .normal)
                
            }
            if currentTag == 3 {
                buttonsArray[3].setImage(chosenImage, for: .normal)
                
            }
            
        }
        
        dismiss(animated:true, completion: nil) //5
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func resetStackView() { // reset the stackView content to none
        
        stackViewTop.subviews.forEach { (item) in // remove the views from stackViewTop
            item.removeFromSuperview()
        }
        stackViewBottom.subviews.forEach { (item) in // remove the views from stackViewBottom
            item.removeFromSuperview()
        }
    }
    
    func createButtons() { // creates four buttons from tag 1 - 4
        
        for tag in 0...3 {
            
            
            let button = UIButton()
            
            button.imageView!.contentMode = .scaleToFill
            button.backgroundColor = .white
            button.setImage(UIImage(named: "Combined Shape"), for: .normal)
            button.tag = tag
            button.addTarget(self, action: #selector(buttonAddImagePressed), for: .touchUpInside)
            buttonsArray.append(button)
            print(button.tag)
            
        }
    }
    
    
}

