//
//  NotificationAlertView.swift
//  DTAlertViewContainerDemo
//
//  Created by Dmitrii Titov on 18.06.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import DTAlertViewContainer

class NotificationAlertViewButton: UIButton {
    
}

class NotificationAlertView: UIView {
    
    weak public var delegate: DTAlertViewContainerProtocol!
    
    public var requiredHeight: CGFloat = 44
    public var frameToFocus: CGRect = .zero
    public var needToFocus: Bool = false
    
    let backgroundView = UIView()

}

extension NotificationAlertView: DTAlertViewProtocol {
        
    public func backgroundPressed() {
        
    }
    
}
