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
    
    func createIDLayer<T:UIView>(forView: T) {
        let layer1 = UILabel.init()
        layer1.backgroundColor = .systemTeal
        layer1.text = " \(forView.accessibilityIdentifier ?? "") "
        layer1.translatesAutoresizingMaskIntoConstraints = false
        layer1.textAlignment = .center
        layer1.numberOfLines = 0
        layer1.tag = -10
        self.view.addSubview(layer1)
        layer1.trailingAnchor.constraint(equalTo: forView.leadingAnchor).isActive = true
        layer1.bottomAnchor.constraint(equalTo: forView.topAnchor).isActive = true
        //layer1.widthAnchor.constraint(equalToConstant: 30).isActive = true
        layer1.heightAnchor.constraint(equalToConstant: 25).isActive = true
        forView.layer.borderWidth = 5
        forView.layer.cornerRadius = 8
        forView.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        forView.bringSubviewToFront(layer1)
        print("view constraints: \(forView)" )
    }

    override func viewDidLayoutSubviews() {
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for vw in self.view.subviews {
            if vw.tag > -1 {
                vw.accessibilityIdentifier = vw.accessibilityIdentifier ?? "v\(self.view.subviews.firstIndex(of: vw) ?? 0)"
                createIDLayer(forView: vw)
            }
        }
    }
    @IBAction func getListOfConstraints(_ sender: Any) {
        let nextVC = story.instantiateViewController(withIdentifier: "listVC") as! ConstraintsList
        nextVC.listData = self.view.constraints.filter({ (lay) -> Bool in
            return !(((lay.firstItem as? UIView)?.accessibilityIdentifier == nil) && ((lay.secondItem as? UIView)?.accessibilityIdentifier == nil) || (lay.firstItem?.tag ?? 0 < 0))
        }) //subviews//
        for vw in self.view.subviews {
            let subViewsConstraints = vw.constraints.filter({ (lay) -> Bool in
                return !(((lay.firstItem as? UIView)?.accessibilityIdentifier == nil) && ((lay.secondItem as? UIView)?.accessibilityIdentifier == nil))
            })
            nextVC.listData.append(contentsOf: subViewsConstraints)
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func cleanAndUpdate(_ sender: Any) {
        let subviews = self.view.subviews.filter({$0.tag != -1})
        for vw in subviews {
            vw.removeFromSuperview()
        }
    }
    
    @IBAction func addElement(_ sender: Any) {
        
    }
}

