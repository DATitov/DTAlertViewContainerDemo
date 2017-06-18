//
//  MainTableViewController.swift
//  DTAlertViewContainerDemo
//
//  Created by Dmitrii Titov on 11.06.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import DTAlertViewContainer

class ConstructorTVC: UITableViewController {
    
    var animaionAppearence: DTAlertViewContainerAppearenceType?
    var positionBinding: DTAlertViewPositionBinding = .centre
    
    @IBOutlet weak var severalTextFieldsSwitcher: UISwitch!
    @IBOutlet weak var blurSwitcher: UISwitch!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            animaionAppearence = DTAlertViewContainerAppearenceType(rawValue: UInt(indexPath.row))
            break
        case 1:
            positionBinding = DTAlertViewPositionBinding(rawValue: UInt(indexPath.row))!
            break
        default:
            break
        }
    }
    
    @IBAction func presentButtonPressed(_ sender: Any) {/*
        let vc = DTAlertViewContainerController()
        let av = PositionBindingAlertView()
        self.alerContainer = vc
        av.demoDelegate = self
        vc.positionBinding = positionBinding
        vc.presentOverVC(self, alert: av, appearenceAnimation: animaionAppearence ?? .fade, completion: nil)
 */
    }
    
}
/*
extension ConstructorTVC: DemoAlertViewDelegate {
    
    func changePositionBinding(positionBinding: DTAlertViewPositionBinding) {
        guard alerContainer != nil else { return }
        alerContainer?.positionBinding = positionBinding
        (alerContainer as! DTAlertViewContainerProtocol).layoutAlertView(animated: true)
    }
    
}
*/
