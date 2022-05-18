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
    
    let FOOD_IMG:[Food] = [
        Food(name: "Oreos", img: "oreos"),
        Food(name: "Pizza Pockets",img:"pizza_pockets"),
        Food(name: "Pop Tarts", img:"pop_tarts"),
        Food(name: "Popsicle", img: "popsicle"),
        Food(name: "Ramen", img:"ramen")
    ]
    
    var foodList:[Food] = []
    
    let imgStackView: UIStackView = {
        let main = UIStackView()
        main.translatesAutoresizingMaskIntoConstraints = false
        return main
    }()
    
    let tableView: UITableView = {
        let main = UITableView()
        main.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
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
        addTableView()
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
        var idx = 0
        FOOD_IMG.map{(food: Food) -> Food in
            let btn = UIButton()
            btn.tag = idx
            btn.setImage(UIImage(named: food.img), for: .normal)
            
            btn.addTarget(self, action: #selector(imgTapped), for: .touchUpInside)
            
            imgStackView.addArrangedSubview(btn)
            idx+=1
            return food
        }
    }
    
    @objc func imgTapped(sender:UIButton!) {
        let food = FOOD_IMG[sender.tag]
        
        foodList.insert(food, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    func addTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count + 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)
        
        if indexPath.row >= foodList.count {
            return cell
        }
        
        let food = foodList[indexPath.row]
        cell.textLabel?.text = food.name
        
        return cell;
    }
    
}
