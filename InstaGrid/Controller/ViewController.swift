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
    
    var currentTag: Int = 0                                  /* declaration currentTag  / initialised at 0
                                                                will allow to manage which button is pressed */

    var gesture = UISwipeGestureRecognizer(target : self, action : #selector(shareFrame))  // declaration gesture handling for the swipe between images
    
    let frameDisplay = FrameHandling()
    let imageHandling = ImageHandling()
    
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
    
    //MARK: - Actions
  
    @IBAction func buttonViewPressed(_ sender: UIButton!) {  /* method handling the pressed button
         changing the frame depending on the frame choose */
        if sender.tag == 1 {    /* frame largeTwo   stackViewTop composed by a large image/ stackViewBottom composed by two small images */
            whichFrame(frame: .largeTwo) // set the frame to the expected frame(Largetwo)
            frameDisplay.stateFrame = .largeTwo // memorised the state of the frame to LargeTwo
        }
        if sender.tag == 2 {    /* frame twoLarge   stackViewTop composed by two small images/  stackViewBottom composed by a large image */
            whichFrame(frame: .twoLarge) // set the frame to the expected frame(twoLarge)
            frameDisplay.stateFrame = .twoLarge // memorised the state of the frame to TwoLarge
        }
        if sender.tag == 3 {    /* frame twoTwo     stackViewTop composed by two small images/ stackViewBottom composed by two small images */
            whichFrame(frame: .twoTwo) // set the frame to the expected frame(twoTwo)
            frameDisplay.stateFrame = .twoTwo // memorised the state of the frame to TwoTwo
        }
    }
    
    // Add Images
    
    @objc func buttonAddImagePressed(sender: UIButton!) { // add image in the button position
        
        setUIImagePickerController()  // call the method setUIImagePickerController
        currentTag = sender.tag // set currenTag to the tag of the button pressed
        
    }
    
    //MARK: -Share Frame
    
    fileprivate func activityViewController() {
        // method manage the share of the frame
        
        let activityViewController = UIActivityViewController(activityItems: [viewGeneral.asImage()], applicationActivities:nil) // create the activityViewController which take via viewGeneral.asImage() a picture of the viewGeneral
        
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if(UIDevice.current.orientation.isPortrait){ // test the iphone orientation for the effect direction UP
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                    self.viewGeneral.transform = .identity // will come back to the original position of viewGeneral
                }, completion:nil)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                    self.viewGeneral.transform = .identity // will come back to the original position of viewGeneral
                }, completion:nil)
            }
        }
        present(activityViewController, animated: true,completion: nil)
        
    }
    
    @objc func shareFrame(_ sender:UISwipeGestureRecognizer) {
        
        if gesture.direction == .left {
          
        self.viewGeneral.viewGeneralSwipeLeft()
        self.activityViewController() // present the activityViewController
            
        } else {
          
        self.viewGeneral.viewGeneralSwipeUp()
        self.activityViewController() // present the activityViewController
        }
        
        
        
    }
    
    
    // Switch Images
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {   // handle the Pan Gesture for the swipe of image
        switch recognizer.state {
        case .began:                 // state("began")
            
            guard let touchView = analyze(recognizer: recognizer) // Get view where interaction did start
                else {
                    return
            }
            
            if whichView(touchView) != 4 { // test if the view touched is one of the view(Image) swipable
            startView = touchView // Remember the start view
            guard let dragView = touchView.snapshotView(afterScreenUpdates: false) else { // Create a "copy" do move along the pan
                recognizer.isEnabled = true // If creating a copy fails, let the gesture recognizer reset
                return
            }
            dragView.alpha = 1
            dragView.center = recognizer.location(in: viewGeneral) // Put the copy right under the touch point
            self.dragView = dragView // Save it for later
            }
                
            else {
                startView = nil
                dragView = nil
            }
            
        case .failed:           //state("failed")
            startView = nil
            dragView = nil
            
        case .changed:          // state("changed")
            dragView?.center = recognizer.location(in: viewGeneral) // Put the copy right under the touch point
            
            if UIDevice.current.orientation.isPortrait{
            dragView?.frame = dragView!.frame.offsetBy(dx: 0 , dy: stackViewDisplay.frame.height)
            }
            else {
            dragView?.frame = dragView!.frame.offsetBy(dx: stackViewDisplay.frame.height , dy: 0)
            }
            
        case .ended:
            defer { // Forget the stored values when this case ends
                startView = nil
                dragView = nil
            }
            
            guard let touchView = analyze(recognizer: recognizer),
                let startView = startView else {
                    return
            }
            if whichView(startView) != 4 && whichView(touchView) != 4 { // check if the startView or the touchView is one of the allowed views
                let startImageIndex = whichView(startView) // gives the index of the first selected view
                let endImageIndex = whichView(touchView) // gives the index of the last selected view
                imageHandling.inverseImage(startImage: startImageIndex, endImage: endImageIndex) // call the method inverseImage
                whichFrame(frame: frameDisplay.stateFrame) // set the frame with the new images swiped
            }
           
        default: // state("something strange happend")
            startView = nil
            dragView = nil
            
        }
    }
   
    func analyze(recognizer: UIPanGestureRecognizer) -> UIView? { // handles the view selected by the touch action
        let touchPoint = recognizer.location(in: recognizer.view) // declaration of the touchPoint, value for having the view where the touchPoint is placed
        
        guard let recognizerAttachedToView = recognizer.view else {
            return nil
        }
        
        guard let hitView = recognizerAttachedToView.hitTest(touchPoint, with: nil) else {
            return nil
        }
        
        return hitView
    }
    
    func whichView(_ view: UIView) -> Int {   /* method checks the view touched and returns an
                                                int  corresponding to the index in buttonsImageArray */
        switch view {
        case stackViewTop.viewWithTag(1): // case the first buttons image is selected
            return 0
            
        case stackViewTop.viewWithTag(2): // case the second buttons image is selected
            return 1
            
        case stackViewBottom.viewWithTag(3): // case the third buttons image is selected
            return 2
            
        case stackViewBottom.viewWithTag(4): // case the fourth buttons image is selected
            return 3
            
        default:    //            return "other view"
            return 4
        }
    }
    
   
    // MARK: UIImagePickerController
    
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // if the chosen image is modified
            imageHandling.buttonsImageArray[currentTag - 1] = chosenImage
        }
        else if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { // if the chosen image is the original one
            imageHandling.buttonsImageArray[currentTag - 1] = chosenImage
        }
        
        whichFrame(frame: frameDisplay.stateFrame)
        dismiss(animated:true, completion: nil) //5
        
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
}
    
    
    // MARK: - Frames handling
    
    // MARK: Buttons Creation
    
    func createButtons(button number: Int) -> UIButton { // creates four buttons from tag 0 - 3
        
        let button = BounceButton() // creates an instance of BounceButton
        
        button.backgroundColor = .white // set backgroundColor to white
        button.setImage(imageHandling.buttonsImageArray[number - 1], for: .normal) // set the image from the buttonsImageArray at index (number - 1)
        button.imageView!.contentMode = .scaleAspectFill // set the contentMode at scaleAspectFill
        button.tag = number // set button.tag at the value number
        button.addTarget(self, action: #selector(buttonAddImagePressed), for: .touchUpInside) // add the action to that button
        
        return button
        
    }
    
    func createViewButtons(buttonChoice number: Int) -> UIButton { // creates three buttons from tag 0 - 2
        
        let button = BounceButton() // creates an instance of BounceButton
        
        button.setBackgroundImage(imageHandling.buttonsFrameArray[number - 1], for: .normal) // set the image from the buttonsImageArray at index (number - 1)
        button.imageView!.contentMode = .scaleAspectFill // set the contentMode at scaleAspectFill
        button.tag = number // set button.tag at the value number
        button.addTarget(self, action: #selector(buttonViewPressed), for: .touchUpInside) // add the action to that button
        
        
        return button
    }
    
    // MARK: Buttons StackView Handling
    
    func setViewLargeTwo() { // displays frame Large and two smalls
        
        let buttonSelected = createViewButtons(buttonChoice: 1)
        buttonSelected.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        stackViewButtons.addArrangedSubview(buttonSelected)
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 2))
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 3))
        
    }
    
    func setViewTwoLarge() { // displays frame two smalls and Large
        
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 1))
        let buttonSelected = createViewButtons(buttonChoice: 2)
        buttonSelected.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        stackViewButtons.addArrangedSubview(buttonSelected)
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 3))
        
    }
    
    func setViewTwoTwo() { // displays frame two smalls and two smalls
        
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 1))
        stackViewButtons.addArrangedSubview(createViewButtons(buttonChoice: 2))
        let buttonSelected = createViewButtons(buttonChoice: 3)
        buttonSelected.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        stackViewButtons.addArrangedSubview(buttonSelected)
        
    }
    
    
    // MARK: StackView Frame Handling
   
    func setStackViewLargeTwo() {      // call resetStackView method
       
        stackViewTop.addArrangedSubview(createButtons(button: 1)) // adds the button to the stackViewTop in position One
        stackViewBottom.addArrangedSubview(createButtons(button: 3)) // adds the button to the stackViewBottom in position three
        stackViewBottom.addArrangedSubview(createButtons(button: 4)) // adds the button to the stackViewBottom in position four
        
    }
    
    func setStackViewTwoLarge() {       // call resetStackView method
        
        stackViewTop.addArrangedSubview(createButtons(button: 1)) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(createButtons(button: 2)) // adds the button to the stackViewTop in position Two
        stackViewBottom.addArrangedSubview(createButtons(button: 3)) // adds the button to the stackViewBottom in position three
        
    }
    
    func setStackViewTwoTwo() {     // call resetStackView method
        
        
        stackViewTop.addArrangedSubview(createButtons(button: 1)) // adds the button to the stackViewTop in position One
        stackViewTop.addArrangedSubview(createButtons(button: 2)) // adds the button to the stackViewTop in position One
        stackViewBottom.addArrangedSubview(createButtons(button: 3)) // adds the button to the stackViewBottom in position Three
        stackViewBottom.addArrangedSubview(createButtons(button: 4)) // adds the button to the stackViewBottom in position Four
        
    }
    
    func resetStackViewFrame() { // reset the stackView content to none
        
        stackViewTop.subviews.forEach { (item) in // remove the views from stackViewTop
            stackViewTop.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
        stackViewBottom.subviews.forEach { (item) in // remove the views from stackViewBottom
            stackViewBottom.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
    }
    
    func resetStackViewButton() { // reset the stackView content to none
        
        stackViewButtons.subviews.forEach { (item) in // remove the views from stackViewButtons
            item.removeFromSuperview()
        }
    }
    
    
    // Mark: Frame configuration
    
    fileprivate func whichFrame(frame: frameState) {
        
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
        viewGeneral.fadeIn()
    }
    
    
}
