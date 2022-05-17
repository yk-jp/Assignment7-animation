//
//  ViewController.swift
//  NavbarAnimation
//
//  Created by Yusuke K on 2022-05-16.
//

import UIKit

class ViewController: UIViewController {
    
    let NAVBAR_HEIGHT:[String:CGFloat] = [
        "before": 88.0,
        "after": 200.0
    ]
    
    var isOpen = false
    
    @IBOutlet var navBar: UIView!
    
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4 ,initialSpringVelocity: 0.2, animations: {
            if !self.isOpen {
                self.navBarHeightAnimation(height: self.NAVBAR_HEIGHT["after"]! - self.NAVBAR_HEIGHT["before"]!)
                self.plusBtnAnimation(degree: .pi/4)
            } else {
                self.navBarHeightAnimation(height: -(self.NAVBAR_HEIGHT["after"]! - self.NAVBAR_HEIGHT["before"]!))
                self.plusBtnAnimation(degree: -1 * .pi/4)
                
            }
            
            self.isOpen = !self.isOpen
            self.view.layoutIfNeeded()
        }
        )
    }
    
    private func plusBtnAnimation(degree: CGFloat) {
        let rotateTransform = CGAffineTransform(rotationAngle: degree)
        self.plusButton.transform = rotateTransform
    }
    
    private func navBarHeightAnimation(height: CGFloat) {
        self.navBarHeightConstraint.constant += height
    }
    
}

