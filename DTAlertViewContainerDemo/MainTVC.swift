//
//  MainTVC.swift
//  DTAlertViewContainerDemo
//
//  Created by Dmitrii Titov on 18.06.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import DTAlertViewContainer

class MainTVC: UITableViewController {
    
    weak var alertContainer: DTAlertViewContainerController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 2:
            let vc = DTAlertViewContainerController()
            var appearenceAnimation: DTAlertViewContainerAppearenceType!
            var av: DTAlertViewProtocol?
            switch indexPath.row {
            case 0: //  Notification
                av = NotificationAlertView()
                vc.positionBinding = .top
                appearenceAnimation = .fromTop
                break
            case 1: //  Action Sheet
                av = ActionSheetAlertView()
                vc.positionBinding = .bottom
                appearenceAnimation = .fromBottom
                let blurEffect = UIBlurEffect(style: .dark)
                vc.backgroundView = UIVisualEffectView(effect: blurEffect)
                break
            default:
                break
            }
            guard let alertView = av else { break }
            vc.presentOverVC(self, alert: alertView as! UIView, appearenceAnimation: appearenceAnimation, completion: nil)
            break
        case 3: //  Position Binding
            let vc = DTAlertViewContainerController()
            var av: DTAlertViewProtocol?
            switch indexPath.row {
            case 0:
                av = PositionBindingAlertView()
                (av as! PositionBindingAlertView).demoDelegate = self
                alertContainer = vc
                let blurEffect = UIBlurEffect(style: .dark)
                vc.backgroundView = UIVisualEffectView(effect: blurEffect)
                break
            case 1:
                av = SeveralTextFieldsAlertView()
                let blurEffect = UIBlurEffect(style: .dark)
                vc.backgroundView = UIVisualEffectView(effect: blurEffect)
                break
            default:
                break
            }
            guard let alertView = av else { break }
            vc.presentOverVC(self, alert: alertView as! UIView, appearenceAnimation: .fade, completion: nil)
            break
        default:
            break
        }
    }
    
}

extension MainTVC: PositionBindingAlertViewDelegate {
    
    func changePositionBinding(positionBinding: DTAlertViewPositionBinding) {
        guard alertContainer != nil else { return }
        alertContainer?.positionBinding = positionBinding
        (alertContainer as! DTAlertViewContainerProtocol).layoutAlertView(animated: true)
    }
    
}
