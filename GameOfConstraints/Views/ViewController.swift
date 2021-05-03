//
//  ViewController.swift
//  GameOfConstraints
//
//  Created by Kanchan Verma on 10/04/2021.
//

import UIKit

class ViewController: UIViewController, updateViews {
    func constraintChanged(newConstraingt: NSLayoutConstraint) {
        let changedConst = self.view.constraints.filter { (const) -> Bool in
            return const.hashValue ==  newConstraingt.hashValue
        }
        if let changed = changedConst.first {
            self.view.removeConstraint(changed)
        }
        DispatchQueue.main.async {
            self.view.addConstraint(newConstraingt)
            self.view.updateConstraints()
            self.view.layoutIfNeeded()
            
        }
    }
    
    let story = UIStoryboard(name: "Main", bundle: Bundle.main)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Work Board"
        
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
        nextVC.listData = self.view.constraints.filter({ (lay) -> Bool in
            return !(((lay.firstItem as? UIView)?.accessibilityIdentifier == nil) && ((lay.secondItem as? UIView)?.accessibilityIdentifier == nil))
        }) //subviews//
        for vw in self.view.subviews {
            let subViewsConstraints = vw.constraints.filter({ (lay) -> Bool in
                return !(((lay.firstItem as? UIView)?.accessibilityIdentifier == nil) && ((lay.secondItem as? UIView)?.accessibilityIdentifier == nil))
            })
            nextVC.listData.append(contentsOf: subViewsConstraints)
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

