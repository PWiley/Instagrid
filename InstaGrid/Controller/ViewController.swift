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
    
    
    
    @IBOutlet weak var swipeToShare: UILabel!               // outlet connection swipeToShare
    @IBOutlet weak var stackViewDisplay: UIStackView!       // outlet connection stackViewDisplay
    @IBOutlet weak var stackViewTop: UIStackView!           // outlet connection stackViewTop
    @IBOutlet weak var stackViewBottom: UIStackView!        // outlet connection stackViewBottom
    @IBOutlet weak var stackViewButtons: UIStackView!       // outlet connection stackViewButtons
    @IBOutlet weak var viewGeneral: UIView!                 // outlet connection viewGeneral
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!    // outlet connection panRecognizer
    
    var buttonsFrameArray = [#imageLiteral(resourceName: "Layout 1"), #imageLiteral(resourceName: "Layout 2.png"), #imageLiteral(resourceName: "Layout 3")]                     // declaration array buttonsFrameArray / initialised with the three different images
    var buttonsImageArray = [#imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape"), #imageLiteral(resourceName: "Combined Shape")]                 // declaration array buttonsImageArray / initialised with the three different images
    var currentTag: Int = 0                                  /* declaration currentTag  / initialised at 0
     will allow to manage which button is pressed */
    var stateFrame = frameState.twoLarge                     /* declaration stateFrame depending on the enumeration frameState /
     initialised at Frame Two small images for stackViewTop and one large image for stackViewBottom */
    // checker le pan avec le bouton si glissé bug
    var gesture = UISwipeGestureRecognizer(target : self, action : #selector(shareFrame))  // declaration gesture handling for the swipe between images
    
    private var startView: UIView?      // declaration startView first view to be touched
    private var dragView: UIView? {     // declaration dragView view which is going to be dragged
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
    
    
    // regarder le code
    // model: créer un ensemble d'images didset tableau
    // animation UIView.animate max 500 ms
    // commenter
    // differentes images,
    // presentation powerpoint/présentation rapport
    // gerer les views autres que Image 1, 2, 3, 4
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        stackViewDisplay.addGestureRecognizer(panRecognizer)  // adds the panRecognizer to stackViewDisplay
        gesture = UISwipeGestureRecognizer(target : self, action : #selector(shareFrame))
        whichOrientation()  // calls whichOrientation method
        self.view.addGestureRecognizer(gesture) // adds the gesture to the view
        
        whichFrame(frame: .twoLarge) // calls whichFrame method and sets the frame
        
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        whichOrientation()
    }
    
    
    //Mark: - Display
    @IBAction func buttonViewPressed(_ sender: UIButton!) {  /* method handling the pressed button
         changing the frame depending on the frame choose*/
        if sender.tag == 1 {    /* frame Largetwo
             stackViewTop composed by a large image
             stackViewBottom composed by two small images */
            whichFrame(frame: .largeTwo) // set the frame to the expected frame(Largetwo)
            stateFrame = .largeTwo // memorised the state of the frame to LargeTwo
            
        }
        if sender.tag == 2 {    /* frame twoLarge
             stackViewTop composed by two small images
             stackViewBottom composed by a large image */
            whichFrame(frame: .twoLarge) // set the frame to the expected frame(twoLarge)
            stateFrame = .twoLarge // memorised the state of the frame to TwoLarge
        }
        if sender.tag == 3 {    /* frame twoTwo
             stackViewTop composed by two small images
             stackViewBottom composed by two small images */
            whichFrame(frame: .twoTwo) // set the frame to the expected frame(twoTwo)
            stateFrame = .twoTwo // memorised the state of the frame to TwoTwo
        }
        
    }
    
    //MARK: - Actions
    
    //    func createGesture(direction: String) {
    //
    //
    //        gesture.direction = .left
    //        gesture.direction = .up
    //
    ////        if direction == "left" {
    ////            gesture.direction = .left
    ////        }
    ////        else {
    ////            gesture.direction = .up
    ////        }
    //        self.view.addGestureRecognizer(gesture)
    //    }
    
    
    
    @objc func buttonAddImagePressed(sender: UIButton!) { // add image in the button position
        
        setUIImagePickerController()
        currentTag = sender.tag
        
        
    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:                 // state("began")
            
            // Get view where interaction did start
            guard let touchView = analyze(recognizer: recognizer)
                
                else {
                    return
            }
            
            // Remember the start view
            
            startView = touchView
            
            // Create a "copy" do move along the pan
            guard let dragView = touchView.snapshotView(afterScreenUpdates: false) else {
                // If creating a copy fails, let the gesture recognizer reset
                
                recognizer.isEnabled = true
                
                return
            }
            dragView.alpha = 1
            // Put the copy right under the touch point
            
            dragView.center = recognizer.location(in: viewGeneral)
            
            
            // Save it for later
            self.dragView = dragView
            
        case .failed:           //state("failed")
            
            startView = nil
            dragView = nil
            
        case .changed:          // state("changed")
            
            // Put the copy right under the touch point
            dragView?.center = recognizer.location(in: viewGeneral)
            dragView?.frame = dragView!.frame.offsetBy(dx: 0 , dy: stackViewDisplay.frame.height)
            
            
            
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
    
    func whichView(_ view: UIView) -> Int {   /* method checks the view touched and returns an int corresponding to
         the index in buttonsImageArray */
        switch view {
        case stackViewTop.viewWithTag(1): // case the first buttons image is selected
            return 0
            
        case stackViewTop.viewWithTag(2): // case the second buttons image is selected
            return 1
            
        case stackViewBottom.viewWithTag(3): // case the third buttons image is selected
            return 2
            
        case stackViewBottom.viewWithTag(4): // case the fourth buttons image is selected
            return 3
            
        default:
            //            return "other view"
            return 4
        }
    }
    
    
    func inverseImage(startImage: Int ,endImage: Int) {
        
        
        let firstImage = buttonsImageArray[startImage]
        let lastImage = buttonsImageArray[endImage]
        
        buttonsImageArray[endImage] = firstImage
        buttonsImageArray[startImage] = lastImage
        
        
    }
    
    @objc func shareFrame() {
        let activityViewController = UIActivityViewController(activityItems: [viewGeneral.asImage()], applicationActivities:nil)
        present(activityViewController, animated: true,completion: nil)
    }
    
    
    
    func createButtons(button number: Int) -> UIButton { // creates four buttons from tag 0 - 3
        
        
//        let button = UIButton()
        let button = BounceButton()
        
        button.backgroundColor = .white
        button.setImage(buttonsImageArray[number - 1], for: .normal)
        button.imageView!.contentMode = .scaleAspectFill
        button.tag = number
        button.addTarget(self, action: #selector(buttonAddImagePressed), for: .touchUpInside)
        
        return button
        
    }
    
    func createViewButtons(buttonChoice number: Int) -> UIButton { // creates three buttons from tag 0 - 2
        
//        let button = UIButton()
        let button = BounceButton()
        
        
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
        stackViewBottom.addArrangedSubview(createButtons(button: 4)) // adds the button to the stackViewBottom in position four
        
    }
    
    fileprivate func setStackViewTwoLarge() {       // call resetStackView method
        
        stackViewTop.addArrangedSubview(createButtons(button: 1)) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(createButtons(button: 2)) // adds the button to the stackViewTop in position Two
        stackViewBottom.addArrangedSubview(createButtons(button: 3)) // adds the button to the stackViewBottom in position three
        
    }
    
    fileprivate func setStackViewTwoTwo() {     // call resetStackView method
        
        
        stackViewTop.addArrangedSubview(createButtons(button: 1)) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(createButtons(button: 2)) // adds the button to the stackViewTop in position One
        stackViewBottom.addArrangedSubview(createButtons(button: 3)) // adds the button to the stackViewBottom in position Three
        stackViewBottom.addArrangedSubview(createButtons(button: 4)) // adds the button to the stackViewBottom in position Four
        
        
        
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
            setStackViewTwoTwo() // set stackView top and bottom (Two small images/ Two small images)
            setViewTwoTwo()
        case .largeTwo:
            setStackViewLargeTwo() // set stackView top and bottom (One large image/ Two small images)
            setViewLargeTwo()
        case .twoLarge:
            setStackViewTwoLarge() // set stackView top and bottom (Two small images/ One large image)
            setViewTwoLarge()
        }
    }
    
    fileprivate func whichOrientation() {
        if UIDevice.current.orientation.isLandscape {    // test if the device is on landscape
            gesture.direction = .left                    // set the gesture direction to left handling
            swipeToShare.text = "Swipe left to share"    // set the title to Swipe left to share
        }
        else {
            gesture.direction = .up                      // set the gesture direction to up handling
            swipeToShare.text = "Swipe up to share"      // set the title to Swipe up to share
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

