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
    //@IBOutlet weak var stackViewTop: UIStackView!
    //@IBOutlet weak var stackViewBottom: UIStackView!
    
    //@IBOutlet weak var buttonViewTwoLarge: UIButton!
    //@IBOutlet weak var buttonViewLargeTwo: UIButton!

    //@IBOutlet weak var buttonViewTwoTwo: UIButton!
    
    
    override func viewDidLoad() {
        buttonViewLargeTwo.imageView!.isHidden = true
        buttonViewTwoTwo.imageView!.isHidden = true
        buttonViewTwoLarge.imageView!.isHidden = false
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()

        view1.backgroundColor = .white
        view2.backgroundColor = .white
        view3.backgroundColor = .white
        view4.backgroundColor = .white
        
        let buttonAdd1 = UIButton(frame: CGRect(x: 44, y: 44, width: 40, height: 40))
        buttonAdd1.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd1.addTarget(self, action: #selector(addImage1), for: .touchUpInside)
        view1.addSubview(buttonAdd1)
        
        let buttonAdd2 = UIButton(frame: CGRect(x: 44 , y: 44, width: 40, height: 40))
        buttonAdd2.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd2.addTarget(self, action: #selector(addImage2), for: .touchUpInside)
        view2.addSubview(buttonAdd2)

        let buttonAdd3 = UIButton(frame: CGRect(x: 115, y: 44 , width: 40, height: 40))
        buttonAdd3.setImage(UIImage(named: "Combined Shape"), for: .normal)
        buttonAdd3.addTarget(self, action: #selector(addImage3), for: .touchUpInside)
        view3.addSubview(buttonAdd3)
        
       

        stackViewTop.addArrangedSubview(view1)
        stackViewTop.addArrangedSubview(view2)
        stackViewBottom.addArrangedSubview(view3)
        


        
     
        
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
        
        buttonViewLargeTwo.imageView!.isHidden = false
        buttonViewTwoLarge.imageView!.isHidden = true
        buttonViewTwoTwo.imageView!.isHidden = true
        
        
    }
    @IBAction func showViewTwoLArge(_ sender: Any) {
        print("button 2")
        
        buttonViewLargeTwo.imageView!.isHidden = true
        buttonViewTwoLarge.imageView!.isHidden = false
        buttonViewTwoTwo.imageView!.isHidden = true
    }
    
    @IBAction func showViewTwoTwo(_ sender: Any) {
        print("button 3")
        
        buttonViewLargeTwo.imageView!.isHidden = true
        buttonViewTwoLarge.imageView!.isHidden = true
        buttonViewTwoTwo.imageView!.isHidden = false
    }
    
}
    


