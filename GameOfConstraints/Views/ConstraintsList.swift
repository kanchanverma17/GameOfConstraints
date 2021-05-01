//
//  ConstraintsList.swift
//  GameOfConstraints
//
//  Created by Kanchan Verma on 16/04/2021.
//

import UIKit

class ConstraintsList: UITableViewController {
    
    var listData: Array<UIView> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "brief")
        cell?.textLabel?.text = ""
        let info = listData[indexPath.row]
        var str = ""
        for constraint in info.constraints {
            str = "\(str) \n \(constraint.firstItem?.accessibilityName ?? info.accessibilityIdentifier).\(constraint.firstAttribute.rawValue) = \(constraint.secondItem?.accessibilityName ?? "SuperView").\(constraint.secondAttribute)*\(constraint.multiplier.description) + \(constraint.constant.description)"
        }
        cell?.textLabel?.text = "\(info.accessibilityIdentifier ?? "") Constraints \n \(str)"
        cell?.textLabel?.numberOfLines = 0
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
