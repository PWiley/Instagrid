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
    @IBOutlet weak var stackViewButtons: UIStackView!
    @IBOutlet weak var viewToShare: UIView!
    @IBOutlet weak var viewGeneral: UIView!
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    
    var buttonsArray = [UIButton]()
    var buttonsImageArray = [#imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape")]
    var viewButtonsArray = [UIButton]()
    var currentTag: Int = 0
    
   
//    var frame: frameState = .largeTwo
//
//    switch frame {
//    case .twoTwo:
//    print("Lots of planets have a north")
//    case .largeTwo:
//    print("Watch out for penguins")
//    case .twoLarge:
//    print("Where the sun rises")
//
//    }
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //createButtons() // creates the four buttons so they can by added later in the two different stackView
                        // stackViewTop will contain maximum two
                        // stackViewBottom will contain maximum two
                        // it will depend on the type of the frame shown
        setViewTwoLarge()
        
        setStackView() // adds the button to the stackViews
        
        frame = frameState.largeTwo
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let gesture = UISwipeGestureRecognizer(target : self, action : #selector(shareFrame))
        if UIDevice.current.orientation.isLandscape { // test if the iphone is in landscape then gesture taking in charge will be the left one
            gesture.direction = .left
            print("left")
        }
        else { // or gesture up taken in charge
            gesture.direction = .up
            print("up")
        }
        
        self.viewToShare.addGestureRecognizer(gesture)
    }
    
    //Mark: - Display
    
    @IBAction func buttonViewPressed(_ sender: UIButton!) {
        
        if sender.tag == 0 {
            print("sender egale 0")
            resetStackView() // call resetStackView method
            
//            stackViewTop.addArrangedSubview(buttonsArray[0]) // adds the button to the stackViewTop in position One
//            stackViewBottom.addArrangedSubview(buttonsArray[2]) // adds the button to the stackViewBottom in position three
//            stackViewBottom.addArrangedSubview(buttonsArray[3]) // adds the button to the stackViewBottom in position four
            
            
            // test
            
            stackViewTop.addArrangedSubview(createButtons(number: 1)) // adds the button to the stackViewTop in position One
            stackViewBottom.addArrangedSubview(createButtons(number: 3)) // adds the button to the stackViewBottom in position three
            stackViewBottom.addArrangedSubview(createButtons(number: 4)) // adds the button to the stackViewBottom in position four
            // fin test
            
            setViewLargeTwo()
        }
        if sender.tag == 1 {
            print("sender egale 1")
            resetStackView() // call resetStackView method
            
//            stackViewTop.addArrangedSubview(buttonsArray[0]) // adds the button to the stackViewTop in position One
//            stackViewTop.addArrangedSubview(buttonsArray[1]) // adds the button to the stackViewTop in position Two
//            stackViewBottom.addArrangedSubview(buttonsArray[2]) // adds the button to the stackViewTop in position Three
            // test
            
            stackViewTop.addArrangedSubview(createButtons(number: 1)) // adds the button to the stackViewTop in position One
            stackViewTop.addArrangedSubview(createButtons(number: 2)) // adds the button to the stackViewTop in position Two
            stackViewBottom.addArrangedSubview(createButtons(number: 3)) // adds the button to the stackViewTop in position Three
            
            
            // fin test
            setViewTwoLarge()
            
        }
        if sender.tag == 2 {
            print("sender egale 2")
            resetStackView() // call resetStackView method
           
//            stackViewTop.addArrangedSubview(buttonsArray[0]) // adds the button to the stackViewTop in position One
//            stackViewTop.addArrangedSubview(buttonsArray[1]) // adds the button to the stackViewTop in position One
//            stackViewBottom.addArrangedSubview(buttonsArray[2]) // adds the button to the stackViewBottom in position Three
//            stackViewBottom.addArrangedSubview(buttonsArray[3]) // adds the button to the stackViewBottom in position Four
            // test
            
            stackViewTop.addArrangedSubview(createButtons(number: 1)) // adds the button to the stackViewTop in position One
            stackViewTop.addArrangedSubview(createButtons(number: 2)) // adds the button to the stackViewTop in position One
            stackViewBottom.addArrangedSubview(createButtons(number: 3)) // adds the button to the stackViewBottom in position Three
            stackViewBottom.addArrangedSubview(createButtons(number: 4
            )) // adds the button to the stackViewBottom in position Four
            // fin test
            setViewTwoTwo()
            
           
        }

       }
    
    //MARK: - Actions
    
    
    
    @objc func buttonAddImagePressed(sender: UIButton!) { // add image in the button position
        print("button tapped")
        setUIImagePickerController()
        currentTag = sender.tag
        print(sender.tag)

    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            analyze(label: "began", recognizer: recognizer)
            print("The first View touched is : \(String(describing: recognizer.view))")
//            print(recognizer)
        case .ended:
            analyze(label: "ended", recognizer: recognizer)
            print("the second View touched is : \(String(describing: recognizer.view))")
            
            
        default:
            break
        }
        
    }
    func analyze(label: String, recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.location(in: recognizer.view)
        
        guard let recognizerAttachedToView = recognizer.view else {
            state("\(label) - \(touchPoint)\nError A")
            return
        }
        
        guard let hitView = recognizerAttachedToView.hitTest(touchPoint, with: nil) else {
            state("\(label) - \(touchPoint)\nError B")
            return
        }
        
        let endView = whichView(hitView)
        state("\(label) - \(touchPoint)\n\(endView)")
    }
    
    func whichView(_ view: UIView) -> UIImageView {
        switch view {
        case buttonsArray[0]:
            return buttonsArray[0].imageView!
        case buttonsArray[1]:
            return buttonsArray[1].imageView!
        case buttonsArray[2]:
            return buttonsArray[2].imageView!
        case buttonsArray[3]:
            return buttonsArray[3].imageView!
            
        default:
            return buttonsArray[0].imageView!
        }
    }
    
    func state(_ text: String) {
        print(text)
    }
    
    @objc func shareFrame() {
        let activityViewController = UIActivityViewController(activityItems: [viewGeneral.asImage()], applicationActivities:nil)
        present(activityViewController, animated: true,completion: nil)
    }
    
    
    func swipeImage(image1: UIImageView, image2: UIImageView) {
        
        
    }
    
   
    
    func createButtons(number: Int) -> UIButton { // creates four buttons from tag 0 - 3
        
        
//            let button = UIButton()
//
//            button.imageView!.contentMode = .scaleAspectFill
//            button.backgroundColor = .white
//            button.setImage(UIImage(named: "Combined Shape"), for: .normal)
//            button.tag = number
//            button.addTarget(self, action: #selector(buttonAddImagePressed), for: .touchUpInside)
//
//        return button
        
        
        // test
       
        
        let button = UIButton()
        
        if buttonsImageArray[number - 1] == #imageLiteral(resourceName: "Combined Shape.png") {
            print(buttonsImageArray[number - 1])
            button.backgroundColor = .white
            button.setImage(buttonsImageArray[number - 1], for: .normal)
        }
        else {
            button.setImage(buttonsImageArray[number - 1], for: .normal)
            print("Je dois avoir une image differente de la croix")
            print(buttonsImageArray[number - 1])
        }
        button.imageView!.contentMode = .scaleAspectFill
        button.tag = number
        button.addTarget(self, action: #selector(buttonAddImagePressed), for: .touchUpInside)
            
        
        return button
        
        // fin test
    }
    func createViewButtons() { // creates three buttons from tag 0 - 2
        
        for tag in 0...2 {
            
            
            let button = UIButton()
            
            button.imageView!.contentMode = .scaleAspectFill
            
           
            button.tag = tag
            button.addTarget(self, action: #selector(buttonViewPressed), for: .touchUpInside)
            viewButtonsArray.append(button)
            
           
            
            
        }
        viewButtonsArray[0].setBackgroundImage(#imageLiteral(resourceName: "Layout 1.png"), for: .normal)
        viewButtonsArray[1].setBackgroundImage(#imageLiteral(resourceName: "Layout 2"), for: .normal)
        viewButtonsArray[2].setBackgroundImage(#imageLiteral(resourceName: "Layout 3"), for: .normal)
        
        stackViewButtons.addArrangedSubview(viewButtonsArray[0])
        stackViewButtons.addArrangedSubview(viewButtonsArray[1])
        stackViewButtons.addArrangedSubview(viewButtonsArray[2])
        
        
        
    }
    
   
    
   
    func setViewLargeTwo() {
        createViewButtons()
        viewButtonsArray[0].setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        viewButtonsArray[1].setImage(#imageLiteral(resourceName: "Layout 2"), for: .normal)
        viewButtonsArray[2].setImage(#imageLiteral(resourceName: "Layout 3"), for: .normal)
        
    }
    func setViewTwoLarge() {
        createViewButtons()
        viewButtonsArray[0].setImage(#imageLiteral(resourceName: "Layout 1"), for: .normal)
        viewButtonsArray[1].setImage(#imageLiteral(resourceName: "Selected.png"), for: .normal)
        viewButtonsArray[2].setImage(#imageLiteral(resourceName: "Layout 3"), for: .normal)
        
        
    }
    func setViewTwoTwo() {
        createViewButtons()
        viewButtonsArray[0].setImage(#imageLiteral(resourceName: "Layout 1"), for: .normal)
        viewButtonsArray[1].setImage(#imageLiteral(resourceName: "Layout 2"), for: .normal)
        viewButtonsArray[2].setImage(#imageLiteral(resourceName: "Selected.png"), for: .normal)
    }
    func setUIImagePickerController() {
        let picker = UIImagePickerController() // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        picker.delegate = self // Make sure ViewController is notified when the user picks an image.
        picker.allowsEditing = false // allows not the editing access to the picker
        picker.sourceType = .photoLibrary // declares the type of the source // Only allow photos to be picked, not taken.
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = UIModalPresentationStyle.currentContext // allows the landscape view
        present(picker, animated: true, completion: nil)
    }
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            //buttonsArray[currentTag].setImage(chosenImage, for: .normal)
            print("cela fonctionne toujours")
            print(chosenImage)
            print(currentTag)
            buttonsImageArray[currentTag - 1] = chosenImage
            
           }
        
        dismiss(animated:true, completion: nil) //5
        
        
        
    }
    
    
    //MARK: StackView handling
    
    fileprivate func setStackView() {
        
//        stackViewTop.addArrangedSubview(buttonsArray[0]) // adds the button to the stackViewTop in position One
//        stackViewTop.addArrangedSubview(buttonsArray[1]) // adds the button to the stackViewTop in position Two
//        stackViewBottom.addArrangedSubview(buttonsArray[2]) // adds the button to the stackViewTop in position three
        
        //createButtons(1)
        //createButtons(2)
        //createButtons(3)
        stackViewTop.addArrangedSubview(createButtons(number: 1)) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(createButtons(number: 2)) // adds the button to the stackViewTop in position Two
        stackViewBottom.addArrangedSubview(createButtons(number: 3)) // adds the button to the stackViewTop in position three

        
        
    }
    
    fileprivate func resetStackView() { // reset the stackView content to none
        
        stackViewTop.subviews.forEach { (item) in // remove the views from stackViewTop
            item.removeFromSuperview()
        }
        stackViewBottom.subviews.forEach { (item) in // remove the views from stackViewBottom
            item.removeFromSuperview()
        }
    }
    
}


extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
extension ViewController: UIGestureRecognizerDelegate {
    
}

//enum frameState {
//    
//    case twoTwo, largeTwo, twoLarge
//    
//    }



