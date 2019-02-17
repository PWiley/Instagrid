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
    
 
   
    @IBOutlet weak var swipeToShare: UILabel!

    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var stackViewDisplay: UIStackView!
    @IBOutlet weak var stackViewTop: UIStackView!
    @IBOutlet weak var stackViewBottom: UIStackView!
    @IBOutlet weak var stackViewButtons: UIStackView!
    @IBOutlet weak var viewGeneral: UIView!
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    
    var buttonsFrameArray = [#imageLiteral(resourceName: "Layout 1"), #imageLiteral(resourceName: "Layout 2.png"), #imageLiteral(resourceName: "Layout 3")]
    var buttonsImageArray = [#imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape")]
    // var viewButtonsArray = [UIButton]()
    var currentTag: Int = 0
    var stateFrame = frameState.twoLarge
    // checker le pan avec le bouton si glissé bug
    
    
    // enum pour les checked button frame choix
   
    

   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //createButtons() // creates the four buttons so they can by added later in the two different stackView
                        // stackViewTop will contain maximum two
                        // stackViewBottom will contain maximum two
                        // it will depend on the type of the frame shown
        
//        setViewTwoLarge()
//
//        setStackViewLargeTwo() // adds the button to the stackViews
        stackViewDisplay.addGestureRecognizer(panRecognizer)
       
        whichFrame(frame: .twoLarge)
        
    }
    
    private var startView: UIView?
    private var dragView: UIView? {
        willSet {
            dragView?.removeFromSuperview()
        }
        didSet {
            guard let dragView = dragView else {
                return
            }
            dragView.isUserInteractionEnabled = false
            view.addSubview(dragView)
        }
    }
    
//        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//            let gesture = UISwipeGestureRecognizer(target : self, action : #selector(shareFrame))
//            if UIDevice.current.orientation.isLandscape { // test if the iphone is in landscape then gesture taking in charge will be the left one
//                gesture.direction = .left
//                swipeToShare.text = "Swipe left to share"
//                arrowToShare.text = "<"
//                print("left")
//            }
//            else { // or gesture up taken in charge
//                gesture.direction = .up
//                swipeToShare.text = "Swipe up to share"
//                arrowToShare.text = "^"
//                print("up")
//            }
//
//            self.viewToShare.addGestureRecognizer(gesture)
//        }
    let gesture = UISwipeGestureRecognizer(target : self, action : #selector(shareFrame))
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("Rotate")
        if UIDevice.current.orientation.isPortrait {
            print("portrait")
            gesture.direction = .up
            print(gesture)
        }
        else {
            print("Landscape")
            gesture.direction = .left
            print(gesture)
        }
        self.viewGeneral.addGestureRecognizer(gesture)
    }
    //Mark: - Display
    
    
    @IBAction func buttonViewPressed(_ sender: UIButton!) {
        
        if sender.tag == 1 {
            //print("sender egale 1")
            whichFrame(frame: .largeTwo)
            stateFrame = .largeTwo
        }
        if sender.tag == 2 {
            //print("sender egale 2")
            whichFrame(frame: .twoLarge)
            stateFrame = .twoLarge
        }
        if sender.tag == 3 {
            //print("sender egale 3")
             whichFrame(frame: .twoTwo)
            stateFrame = .twoTwo
        }

       }
    
    //MARK: - Actions
    
    
    
    @objc func buttonAddImagePressed(sender: UIButton!) { // add image in the button position
        
        setUIImagePickerController()
        currentTag = sender.tag
       

    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            //state("began")
            
            // Get view where interaction did start
            guard let touchView = analyze(recognizer: recognizer)
                
                else {
                    return
            }
            
            // Remember the start view
            
            startView = touchView
            //print(startView)
            
            // Create a "copy" do move along the pan
            guard let dragView = touchView.snapshotView(afterScreenUpdates: false) else {
                // If creating a copy fails, let the gesture recognizer reset
//                recognizer.isEnabled = false
                recognizer.isEnabled = true
                
                return
            }
            dragView.alpha = 1
            // Put the copy right under the touch point
            //            dragView.center = recognizer.location(in: recognizer.view)
            dragView.center = recognizer.location(in: viewGeneral)
            //dragView.frame = dragView.frame.offsetBy(dx: 0, dy: 30)
            
            // Save it for later
            self.dragView = dragView
            
        case .failed:
            //state("failed")
            
            startView = nil
            dragView = nil
            
        case .changed:
            //state("changed")
            
            // Put the copy right under the touch point
            dragView?.center = recognizer.location(in: viewGeneral)
            dragView?.frame = dragView!.frame.offsetBy(dx: 0 , dy: stackViewDisplay.frame.height)
//            let transformation = CGAffineTransform(translationX: recognizer.translation(in: stackViewDisplay).x, y: recognizer.translation(in: stackViewDisplay).y + 200)
//            dragView?.transform = transformation
            
            
        case .ended:
            // Forget the stored values when this case ends
            defer {
                startView = nil
                dragView = nil
            }
            
            guard let touchView = analyze(recognizer: recognizer),
                let startView = startView else {
                    return
            }
            let startImageIndex = whichView(startView)
            let endImageIndex = whichView(touchView)
            
            inverseImage(startImage: startImageIndex, endImage: endImageIndex)
           
            whichFrame(frame: stateFrame)
            
            
        default:
            // state("something strange happend")
            
            startView = nil
            dragView = nil
            
        }
    }
    
    

    
    func analyze(recognizer: UIPanGestureRecognizer) -> UIView? {
        let touchPoint = recognizer.location(in: recognizer.view)
        
        guard let recognizerAttachedToView = recognizer.view else {
            return nil
        }
        
        guard let hitView = recognizerAttachedToView.hitTest(touchPoint, with: nil) else {
            return nil
        }
        
        return hitView
    }
    
    func whichView(_ view: UIView) -> Int {
        switch view {
        case stackViewTop.viewWithTag(1):
            //print("StackViewTop element 1")
            return 0
            
        case stackViewTop.viewWithTag(2):
            //print("StackViewTop element 2")
            return 1
            
        case stackViewBottom.viewWithTag(3):
            //print("StackViewBottom element 1")
            return 2
            
        case stackViewBottom.viewWithTag(4):
            //print("StackViewBottom element 2")
            return 3
            
        default:
            //            return "other view"
            return 1
        }
    }
    
    
    func inverseImage(startImage: Int ,endImage: Int) {
        
   
    let firstImage = buttonsImageArray[startImage]
    let lastImage = buttonsImageArray[endImage]
    
    buttonsImageArray[endImage] = firstImage
    buttonsImageArray[startImage] = lastImage
      
//    print(lastImage)
//    print(firstImage)
//        print(whichFrame(frame: stateFrame))
//    whichFrame(frame: stateFrame) // cela fonctionne mais faire le refresh avec le tableau d'images
    }
    
    @objc func shareFrame() {
        let activityViewController = UIActivityViewController(activityItems: [viewGeneral.asImage()], applicationActivities:nil)
        present(activityViewController, animated: true,completion: nil)
    }
    
   
    
    func createButtons(button number: Int) -> UIButton { // creates four buttons from tag 0 - 3
        
        
        let button = UIButton()
        
        button.backgroundColor = .white
        button.setImage(buttonsImageArray[number - 1], for: .normal)
        button.imageView!.contentMode = .scaleAspectFill
        button.tag = number
        button.addTarget(self, action: #selector(buttonAddImagePressed), for: .touchUpInside)
            
       return button
      
    }
    
    func createViewButtons(buttonChoice number: Int) -> UIButton { // creates three buttons from tag 0 - 2

        let button = UIButton()
        
        
        button.setBackgroundImage(buttonsFrameArray[number - 1], for: .normal)
        button.imageView!.contentMode = .scaleAspectFill
        button.tag = number
        button.addTarget(self, action: #selector(buttonViewPressed), for: .touchUpInside)
        
            
          return button
    }
    

   
    func setViewLargeTwo() {
        
        let buttonSelected = createViewButtons(buttonChoice: 1)
        buttonSelected.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        stackViewButtons.addArrangedSubview(buttonSelected)
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 2))
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 3))
        
    }
    func setViewTwoLarge() {
       
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 1))
        let buttonSelected = createViewButtons(buttonChoice: 2)
        buttonSelected.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        stackViewButtons.addArrangedSubview(buttonSelected)
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 3))
        
    }
    func setViewTwoTwo() {
       
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 1))
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 2))
        let buttonSelected = createViewButtons(buttonChoice: 3)
        buttonSelected.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        stackViewButtons.addArrangedSubview(buttonSelected)
        
    }
    func setUIImagePickerController() {
        let picker = UIImagePickerController() // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        picker.delegate = self // Make sure ViewController is notified when the user picks an image.
        picker.allowsEditing = true // allows not the editing access to the picker
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
            buttonsImageArray[currentTag - 1] = chosenImage
           }

        whichFrame(frame: stateFrame)
        dismiss(animated:true, completion: nil) //5
        
    }
    
    //MARK: StackView handling
    
    fileprivate func setStackViewLargeTwo() {
        // call resetStackView method
      

        stackViewTop.addArrangedSubview(createButtons(button: 1)) // adds the button to the stackViewTop in position One
        stackViewBottom.addArrangedSubview(createButtons(button: 3)) // adds the button to the stackViewBottom in position three
        stackViewBottom.addArrangedSubview(createButtons(button: 4))
    }
    
    fileprivate func setStackViewTwoLarge() {       // call resetStackView method
        
        stackViewTop.addArrangedSubview(createButtons(button: 1)) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(createButtons(button: 2)) // adds the button to the stackViewTop in position Two
        stackViewBottom.addArrangedSubview(createButtons(button: 3))
    }
    
    fileprivate func setStackViewTwoTwo() {     // call resetStackView method
        
      
        stackViewTop.addArrangedSubview(createButtons(button: 1)) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(createButtons(button: 2)) // adds the button to the stackViewTop in position One
        stackViewBottom.addArrangedSubview(createButtons(button: 3)) // adds the button to the stackViewBottom in position Three
        stackViewBottom.addArrangedSubview(createButtons(button: 4)) // adds the button to the stackViewBottom in position Four
        // fin test
       
    }
    
  
    
    fileprivate func resetStackViewFrame() { // reset the stackView content to none
        
        stackViewTop.subviews.forEach { (item) in // remove the views from stackViewTop
            stackViewTop.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
        stackViewBottom.subviews.forEach { (item) in // remove the views from stackViewBottom
            stackViewBottom.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
    }
    fileprivate func resetStackViewButton() { // reset the stackView content to none
        
        stackViewButtons.subviews.forEach { (item) in // remove the views from stackViewButtons
            item.removeFromSuperview()
        }
    }
    
    
    // Mark: Frame configuration
    
    func whichFrame(frame: frameState) {
        
        resetStackViewFrame()
        resetStackViewButton()
        
        switch frame {
        case .twoTwo:
            //print("Lots of planets have a north")
            
            setStackViewTwoTwo() // set stackView top and bottom (Two small images/ Two small images)
            setViewTwoTwo()
        case .largeTwo:
            //print("Watch out for penguins")
            
            setStackViewLargeTwo() // set stackView top and bottom (One large image/ Two small images)
            setViewLargeTwo()
        case .twoLarge:
            //print("Where the sun rises")
           
            setStackViewTwoLarge() // set stackView top and bottom (Two small images/ One large image)
            setViewTwoLarge()
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

enum frameState {
    
    case twoTwo, largeTwo, twoLarge
    
}

