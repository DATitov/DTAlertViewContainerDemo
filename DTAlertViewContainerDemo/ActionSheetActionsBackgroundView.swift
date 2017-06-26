//
//  ActionSheetActionsBackgroundView.swift
//  DTAlertViewContainerDemo
//
//  Created by Dmitrii Titov on 26.06.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class ActionSheetActionsBackgroundView: UIView {
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
}
