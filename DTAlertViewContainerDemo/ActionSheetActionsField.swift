//
//  ActionSheetActionsField.swift
//  DTAlertViewContainerDemo
//
//  Created by Dmitrii Titov on 26.06.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class ActionSheetActionsField: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        let attributes = [
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15),
            NSForegroundColorAttributeName : UIColor(white: 0.2, alpha: 1)
            ] as [String : Any]
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "What empty action do you like more?", attributes: attributes)
        return label
    }()
    
    let button1: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("Empty Action 1", for: .normal)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitle("Empty Action 2", for: .normal)
        return button
    }()
    
    let separator1 = UIView()
    let separator2 = UIView()

    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
        for separator in [separator1, separator2] {
            separator.backgroundColor = UIColor.lightGray
        }
        
        for view in [titleLabel,
                     button1,
                     button2,
                     separator1,
                     separator2] {
            self.addSubview(view)
        }
        
        self.configureView()
    }
    
    func configureView() {
        layer.cornerRadius = 12
        self.backgroundColor = UIColor.white
        layer.masksToBounds = true
    }
    
}

extension ActionSheetActionsField { // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let separatorHeight: CGFloat = 0.5
        let itemHeight = (frame.size.height - separatorHeight * 2) / 3
        let width = frame.size.width
        titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: itemHeight)
        separator1.frame = CGRect(x: 0, y: itemHeight, width: width, height: separatorHeight)
        button1.frame = CGRect(x: 0, y: itemHeight + separatorHeight, width: width, height: itemHeight)
        separator2.frame = CGRect(x: 0, y: itemHeight * 2 + separatorHeight, width: width, height: separatorHeight)
        button2.frame = CGRect(x: 0, y: (itemHeight + separatorHeight) * 2, width: width, height: itemHeight)
    }
    
}
