//
//  NotificationBackgroundView.swift
//  DTAlertViewContainerDemo
//
//  Created by Dmitrii Titov on 26.06.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class NotificationBackgroundView: UIView {
    
    let headerHeight = 30.0 as CGFloat
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 209 / 255, green: 218 / 255, blue: 223 / 255, alpha: 0.9)
        return view
    }()
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 225 / 255, green: 232 / 255, blue: 233 / 255, alpha: 0.8)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
        self.addSubview(headerView)
        self.addSubview(bottomView)
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: headerHeight)
        bottomView.frame = CGRect(x: 0, y: headerHeight, width: frame.size.width, height: frame.size.height - headerHeight)
    }
    
}
