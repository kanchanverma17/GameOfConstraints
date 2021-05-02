//
//  ConstraintsVC.swift
//  GameOfConstraints
//
//  Created by Kanchan Verma on 29/04/2021.
//

import UIKit

class ConstraintsVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var toggleIsActive: UISwitch!
    @IBOutlet weak var FirstObj: UITextField!
    var theConstraint: NSLayoutConstraint!
    @IBOutlet weak var priority: UITextField!
    @IBOutlet weak var offSet: UITextField!
    @IBOutlet weak var multiplier: UITextField!
    @IBOutlet weak var SecObj: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        FirstObj.isUserInteractionEnabled = false
        SecObj.isUserInteractionEnabled = false
        FirstObj.text = "\((theConstraint.firstItem as? UIView)?.accessibilityIdentifier ?? theConstraint.firstItem?.identifier ?? "").\(theConstraint.firstAttribute.readableAttr())"
        SecObj.text = "\((theConstraint.secondItem as? UIView)?.accessibilityIdentifier ?? theConstraint.secondItem?.identifier ?? "").\(theConstraint.secondAttribute.readableAttr())"
        if theConstraint.secondAttribute.rawValue == 0 {
            SecObj.text = ""
        }
        priority.text = "\(theConstraint.priority.rawValue)"
        offSet.text = "\(theConstraint.constant)"
        multiplier.text = SecObj.text?.isEmpty ?? true ? "" : "\(theConstraint.multiplier)"
        toggleIsActive.isOn = theConstraint.isActive
    }
   
    @IBAction func isActiveToggle(_ sender: Any) {
    }
    
    @IBAction func updateFirstScreen(_ sender: Any) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
