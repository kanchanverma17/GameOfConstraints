//
//  ConstraintsVC.swift
//  GameOfConstraints
//
//  Created by Kanchan Verma on 29/04/2021.
//

import UIKit

protocol updateViews {
    func constraintChanged(newConstraingt: NSLayoutConstraint)
}

enum errorType {
    case prior
}
class ConstraintsVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var toggleIsActive: UISwitch!
    @IBOutlet weak var FirstObj: UITextField!
    var theConstraint: NSLayoutConstraint!
    @IBOutlet weak var priority: UITextField!
    @IBOutlet weak var offSet: UITextField!
    @IBOutlet weak var multiplier: UITextField!
    @IBOutlet weak var SecObj: UITextField!
    var updateInitialVW: updateViews?
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
        theConstraint.isActive = !theConstraint.isActive
    }
    
    @IBAction func updateFirstScreen(_ sender: Any) {
        if !validatepriority() {
            showError(forCase: .prior)
            return
        }
        theConstraint.priority = UILayoutPriority.init((priority.text as NSString?)?.floatValue ?? 0.0)
        theConstraint.constant = CGFloat((offSet.text as NSString?)?.floatValue ?? 0.0)
        updateInitialVW?.constraintChanged(newConstraingt: theConstraint)
        self.navigationController?.popToRootViewController(animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func validatepriority() -> Bool {
        return (((priority.text as NSString?)?.floatValue ?? 0.0) > 0) && (((priority.text as NSString?)?.floatValue ?? 0.0) < 1001)
    }
    func showError(forCase: errorType) {
        var msg = ""
        switch forCase {
        case .prior:
            msg = "Priorities must be greater than 0 and less or equal to NSLayoutPriorityRequired, which is 1000.000000."
        }
        let alert = UIAlertController.init(title: "Warning", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
