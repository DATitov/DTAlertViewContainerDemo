//
//  ActionSheetAlertView.swift
//  DTAlertViewContainerDemo
//
//  Created by Dmitrii Titov on 26.06.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import DTAlertViewContainer

class ActionSheetAlertView: UIView {
    
    weak public var delegate: DTAlertViewContainerProtocol!
    
    public var requiredHeight: CGFloat = 300
    public var frameToFocus: CGRect = .zero
    public var needToFocus: Bool = false

    let actionsField = ActionSheetActionsField()
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
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
        self.addSubview(cancelButton)
        self.addSubview(actionsField)
        
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        self.configureView()
    }
    
    func configureView() {
        self.backgroundColor = UIColor.clear
    }

}

extension ActionSheetAlertView { // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cancelButtonHeight: CGFloat = 70
        let verticalOffset: CGFloat = 12
        actionsField.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - cancelButtonHeight - verticalOffset * 2)
        cancelButton.frame = CGRect(x: 0, y: frame.size.height - cancelButtonHeight - verticalOffset,
                                    width: frame.size.width, height: cancelButtonHeight)
    }
    
}

extension ActionSheetAlertView: DTAlertViewProtocol {
    
    public func backgroundPressed() {
        delegate.dismiss()
    }
    
}

extension ActionSheetAlertView { // MARK: Actions
    
    @objc func cancelButtonPressed() {
        delegate.dismiss()
    }
    
}
