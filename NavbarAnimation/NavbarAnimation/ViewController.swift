//
//  ViewController.swift
//  NavbarAnimation
//
//  Created by Yusuke K on 2022-05-16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var navBar: UIView!
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4 ,initialSpringVelocity: 0.2, animations: {
            //            self.navBar.frame.size.height = 200
            self.navBarHeightConstraint.constant += (200-self.navBarHeightConstraint.constant)
            self.view.layoutIfNeeded()
        }
        )
    }
    
}

