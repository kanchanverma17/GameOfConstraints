//
//  ViewController.swift
//  GameOfConstraints
//
//  Created by Kanchan Verma on 10/04/2021.
//

import UIKit

class ViewController: UIViewController {
    let story = UIStoryboard(name: "Main", bundle: Bundle.main)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Work Board"
        
        // Do any additional setup after loading the view.
    }
    
    func createIDLayer<T:UIView>(forView: T) {//-> T {
        let layer1 = UILabel.init()
        layer1.backgroundColor = .systemTeal
        layer1.text = forView.accessibilityIdentifier
        layer1.sizeToFit()
        forView.addSubview(layer1)
        layer1.frame.origin = CGPoint(x: -layer1.frame.size.width, y: -layer1.frame.size.height)
        forView.bringSubviewToFront(layer1)
    }

    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for vw in self.view.subviews {
            vw.accessibilityIdentifier = "v\(self.view.subviews.firstIndex(of: vw) ?? 0)"
            createIDLayer(forView: vw)
        }
    }
    @IBAction func getListOfConstraints(_ sender: Any) {
        let nextVC = story.instantiateViewController(withIdentifier: "listVC") as! ConstraintsList
        nextVC.listData = self.view.subviews//.constraints
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

