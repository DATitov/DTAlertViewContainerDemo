//
//  PositionBindingAlertView.swift
//  DTAlertViewContainerDemo
//
//  Created by Dmitrii Titov on 08.06.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import DTAlertViewContainer

protocol PositionBindingAlertViewDelegate: class {
    func changePositionBinding(positionBinding: DTAlertViewPositionBinding)
}

class PositionBindingAlertView: UIView {
    
    weak var delegate: DTAlertViewContainerProtocol?
    weak var demoDelegate: PositionBindingAlertViewDelegate?
    
    var requiredHeight = 0.0 as CGFloat
    var frameToFocus = CGRect.zero
    var needToFocus = false
    
    let topButton: UIButton = {
        let button = UIButton()
        button.setTitle("Top Binding", for: .normal)
        return button
    }()
    let bottomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bottom Binding", for: .normal)
        return button
    }()
    let centreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Centre Binding", for: .normal)
        return button
    }()
    let leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        return button
    }()
    let rightButton: UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        return button
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
        for view in [topButton,
                     bottomButton,
                     leftButton,
                     rightButton,
                     centreButton] {
                        self.addSubview(view)
        }
        
        for button in [topButton,
                       bottomButton,
                       leftButton,
                       rightButton,
                       centreButton] {
                        button.setTitleColor(UIColor.blue, for: .normal)
        }
        
        topButton.addTarget(self, action: #selector(topButtonPressed), for: .touchUpInside)
        bottomButton.addTarget(self, action: #selector(bottomButtonPressed), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(leftButtonPressed), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
        centreButton.addTarget(self, action: #selector(centreButtonPressed), for: .touchUpInside)
        
        self.backgroundColor = UIColor.white
        self.requiredHeight = 200.0
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 5
    }
    
}

extension PositionBindingAlertView: DTAlertViewProtocol {
    
    public func backgroundPressed() {
        delegate?.dismiss()
    }
    
}

extension PositionBindingAlertView { // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let verticalOffset = 10.0 as CGFloat
        let horisontalOffset = 10.0 as CGFloat
        
        let buttonHeight = 30.0 as CGFloat
        let buttonsAdditionOffset = 10.0 as CGFloat
        
        
        topButton.frame = CGRect(x: horisontalOffset + buttonHeight + buttonsAdditionOffset, y: verticalOffset,
                                 width: self.frame.size.width - (horisontalOffset + buttonHeight + buttonsAdditionOffset) * 2, height: buttonHeight)
        bottomButton.frame = CGRect(x: horisontalOffset + buttonHeight + buttonsAdditionOffset, y: self.frame.size.height - buttonHeight - verticalOffset,
                                    width: self.frame.size.width - (horisontalOffset + buttonHeight + buttonsAdditionOffset) * 2, height: buttonHeight)
        leftButton.frame = CGRect(x: horisontalOffset, y: verticalOffset + buttonHeight + buttonsAdditionOffset,
                                  width: buttonHeight, height: self.frame.size.height - (verticalOffset + buttonHeight + buttonsAdditionOffset) * 2)
        rightButton.frame = CGRect(x: self.frame.size.width - buttonHeight - horisontalOffset, y: verticalOffset + buttonHeight + buttonsAdditionOffset,
                                   width: buttonHeight, height: self.frame.size.height - (verticalOffset + buttonHeight + buttonsAdditionOffset) * 2)
        centreButton.frame = CGRect(x: (self.frame.size.width - 150) / 2, y: (self.frame.size.height - buttonHeight) / 2,
                                    width: 150, height: buttonHeight)
    }
    
}

extension PositionBindingAlertView { // MARK: Actions
    
    @objc func topButtonPressed() {
        demoDelegate?.changePositionBinding(positionBinding: .top)
    }
    
    @objc func bottomButtonPressed() {
        demoDelegate?.changePositionBinding(positionBinding: .bottom)
    }
    
    @objc func leftButtonPressed() {
        demoDelegate?.changePositionBinding(positionBinding: .left)
    }
    
    @objc func rightButtonPressed() {
        demoDelegate?.changePositionBinding(positionBinding: .right)
    }
    
    @objc func centreButtonPressed() {
        demoDelegate?.changePositionBinding(positionBinding: .centre)
    }
    
}
