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
    
    let imgStackView: UIStackView = {
        let main = UIStackView()
        main.translatesAutoresizingMaskIntoConstraints = false
        return main
    }()
    
    var isOpen = false
    
    @IBOutlet var navBar: UIView!
    
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStackView()
        
    }
    
    func addStackView() {
        navBar.addSubview(imgStackView)
        
        // set constraints
        imgStackView.alignment = .center
        imgStackView.distribution = .fillEqually
        imgStackView.isHidden = true
        imgStackView.spacing = 20
        
        NSLayoutConstraint.activate([
            imgStackView.heightAnchor.constraint(equalToConstant: NAVBAR_HEIGHT["after"]! - NAVBAR_HEIGHT["before"]!),
            imgStackView.widthAnchor.constraint(equalTo: navBar.widthAnchor),
            imgStackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor),
            imgStackView.centerXAnchor.constraint(equalTo: navBar.centerXAnchor)
        ])
        
        // add image
        let img1 = UIImageView(image: UIImage(named: "oreos"))
        let img2 = UIImageView(image: UIImage(named: "pizza_pockets"))
        let img3 = UIImageView(image: UIImage(named: "pop_tarts"))
        let img4 = UIImageView(image: UIImage(named: "popsicle"))
        let img5 = UIImageView(image: UIImage(named: "ramen"))
        
        img1.contentMode = .scaleAspectFit
        img2.contentMode = .scaleAspectFit
        img3.contentMode = .scaleAspectFit
        img4.contentMode = .scaleAspectFit
        img5.contentMode = .scaleAspectFit
        
        imgStackView.addArrangedSubview(img1)
        imgStackView.addArrangedSubview(img2)
        imgStackView.addArrangedSubview(img3)
        imgStackView.addArrangedSubview(img4)
        imgStackView.addArrangedSubview(img5)
    }
    
    
//    func addImageView() {
//        var imageView : UIImageView
//           imageView  = UIImageView(frame:CGRectMake(10, 50, 100, 300));
//           imageView.image = UIImage(named:"image.jpg")
//           self.view.addSubview(imageView)
//    }
//
    
//    private func subStackView() -> UIStackView {
//        imgStackView.addArrangedSubview([UIView(), UIView()])
//
//
//            NSLayoutConstraint.activate([
//                    sv.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
//                    sv.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//              ])
//
//            return sv
//        }
    
    
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
            self.imgStackView.isHidden = !self.imgStackView.isHidden
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

