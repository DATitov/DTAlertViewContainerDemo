//
//  DemoAlertView.swift
//  DTAlertWrapperController
//
//  Created by Dmitrii Titov on 31.05.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import DTAlertViewContainer

enum SeveralTextFieldsAlertViewState {
    case start
    case mistake
    case solved
}

class SeveralTextFieldsAlertView: UIView {
    
    weak public var delegate: DTAlertViewContainerProtocol!
    
    public var requiredHeight: CGFloat = 44
    public var frameToFocus: CGRect = .zero
    public var needToFocus: Bool = false
    
    var state = SeveralTextFieldsAlertViewState.start
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Demo"
        label.textAlignment = .center
        return label
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let question1Label: UILabel = {
        let label = UILabel()
        label.text = "2 + 2 ="
        label.textAlignment = .right
        return label
    }()
    let question2Label: UILabel = {
        let label = UILabel()
        label.text = "2 x 2 ="
        label.textAlignment = .right
        return label
    }()
    
    let question1TextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.placeholder = "?"
        return textField
    }()
    let question2TextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.placeholder = "?"
        return textField
    }()
    let checkButton: UIButton = {
        let checkButton = UIButton()
        checkButton.setTitle("Check", for: .normal)
        return checkButton
    }()
    let tryAgainButton: UIButton = {
        let checkButton = UIButton()
        checkButton.setTitle("Try again", for: .normal)
        return checkButton
    }()
    let cancelButton: UIButton = {
        let checkButton = UIButton()
        checkButton.setTitle("Cencel", for: .normal)
        return checkButton
    }()
    let activityIdicator = UIActivityIndicatorView()
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
        for view in [backgroundView,
                     titleLabel,
                     resultLabel,
                     checkButton,
                     tryAgainButton,
                     cancelButton,
                     question1Label,
                     question2Label,
                     activityIdicator,
                     question1TextField,
                     question2TextField] {
                        self.addSubview(view)
        }
        
        activityIdicator.color = UIColor.black
        layer.cornerRadius = 6
        self.setupToolBar()
        checkButton.addTarget(self, action: #selector(self.checkButtonPressed), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.cancelButtonPressed), for: .touchUpInside)
        tryAgainButton.addTarget(self, action: #selector(self.tryAgainButtonPressed), for: .touchUpInside)
        requiredHeight = 200
        
        question1TextField.delegate = self
        question2TextField.delegate = self
        
        self.tryAgainButton.alpha = 0
        self.resultLabel.alpha = 0
    }
    
    func setupToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.donePressed))
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("cancel", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        question1TextField.inputAccessoryView = toolBar
        question2TextField.inputAccessoryView = toolBar
    }
    func donePressed() {
        if question1TextField.isFirstResponder {
            delegate.performTextInputSwitch({
                self.question2TextField.becomeFirstResponder()
            })
        }else{
            question2TextField.resignFirstResponder()
            self.checkButtonPressed()
        }
    }
    func cancelPressed() {
        question1TextField.resignFirstResponder()
        question2TextField.resignFirstResponder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = 32.0 as CGFloat
        let horisontalOffset = 15.0 as CGFloat
        let tfWidth = 32.0 as CGFloat
        let labelWidth = 100.0 as CGFloat
        let titleLabelWidth = 100.0 as CGFloat
        let buttonsHeight = 40.0 as CGFloat
        let betweenBackgroundAndButtonsSpace = 5.0 as CGFloat
        let backgroundHeight: CGFloat = self.frame.size.height - buttonsHeight - betweenBackgroundAndButtonsSpace
        let backgroundViewWidth = 200.0 as CGFloat
        
        let question1YOrigin = height + (backgroundHeight - height) / 3 - height / 2
        let question2YOrigin = height + (backgroundHeight - height) * 2 / 3 - height / 2
            
        titleLabel.frame = CGRect(x: (frame.size.width - titleLabelWidth) / 2, y: 0, width: titleLabelWidth, height: height)
        resultLabel.frame = CGRect(x: (self.frame.size.width - backgroundViewWidth) / 2, y: 0,
                                   width: backgroundViewWidth, height: backgroundHeight)
        question1Label.frame = CGRect(x: frame.size.width / 2 - labelWidth, y: question1YOrigin,
                                      width: labelWidth, height: height)
        question2Label.frame = CGRect(x: frame.size.width / 2 - labelWidth, y: question2YOrigin,
                                      width: labelWidth, height: height)
        question1TextField.frame = CGRect(x: question1Label.frame.maxX + horisontalOffset, y: question1YOrigin,
                                          width: tfWidth, height: height)
        question2TextField.frame = CGRect(x: question2Label.frame.maxX + horisontalOffset, y: question2YOrigin,
                                          width: tfWidth, height: height)
        activityIdicator.frame = CGRect(x: (frame.size.width - 20) / 2, y: (frame.size.height - 20) / 2 - 10, width: 20, height: 20)
        backgroundView.frame = CGRect(x: (self.frame.size.width - backgroundViewWidth) / 2, y: 0,
                                      width: backgroundViewWidth, height: backgroundHeight)
        
        let buttonsHorisontalOffset = 5.0 as CGFloat
        let buttonsWidth = (backgroundViewWidth - 2 * buttonsHorisontalOffset) / 2
        checkButton.frame = CGRect(x: frame.size.width / 2 + buttonsHorisontalOffset, y: frame.size.height - buttonsHeight,
                                   width: buttonsWidth, height: buttonsHeight)
        tryAgainButton.frame = CGRect(x: frame.size.width / 2 + buttonsHorisontalOffset, y: frame.size.height - buttonsHeight,
                                      width: buttonsWidth, height: buttonsHeight)
        cancelButton.frame = {
            if state == .solved {
                return CGRect(x: (frame.size.width - backgroundViewWidth) / 2 + buttonsHorisontalOffset, y: frame.size.height - buttonsHeight,
                              width: backgroundViewWidth - buttonsHorisontalOffset * 2, height: buttonsHeight)
            }else{
                return CGRect(x: frame.size.width / 2 - buttonsWidth - buttonsHorisontalOffset, y: frame.size.height - buttonsHeight,
                       width: buttonsWidth, height: buttonsHeight)
            }
        }()
    }
    
}

extension SeveralTextFieldsAlertView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.frameToFocus = textField.frame
        self.needToFocus = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(question1TextField) {
            delegate.performTextInputSwitch({
                self.question2TextField.becomeFirstResponder()
            })
        }else if textField.isEqual(question2TextField) {
            textField.resignFirstResponder()
            self.checkButtonPressed()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
}

extension SeveralTextFieldsAlertView { // MARK: Actions
    
    @objc func cancelButtonPressed() {
        delegate.dismiss()
    }
    
    @objc func tryAgainButtonPressed() {
        self.requiredHeight = 200
        self.delegate.layoutAlertView(animated: true)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut,
                       animations: {
                        for view in [self.question1Label,
                                     self.question2Label,
                                     self.question1TextField,
                                     self.question2TextField,
                                     self.titleLabel,
                                     self.checkButton] {
                                        view.alpha = 1.0
                        }
                        for view in [self.resultLabel,
                                     self.tryAgainButton] {
                                        view.alpha = 0
                        }
        },
                       completion: nil)
        
    }
    
    @objc func checkButtonPressed() {
        activityIdicator.startAnimating()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut,
                       animations: {
                        for view in [self.question1Label,
                                     self.question2Label,
                                     self.question1TextField,
                                     self.question2TextField,
                                     self.titleLabel,
                                     self.checkButton] {
                            view.alpha = 0.4
                        }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.activityIdicator.stopAnimating()
            weakSelf.requiredHeight = 140
            if weakSelf.question1TextField.text == "4" &&
                weakSelf.question2TextField.text == "4"  {
                weakSelf.state = .solved
            }else{
                weakSelf.state = .mistake
            }
            weakSelf.delegate.layoutAlertView(animated: true)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut,
                           animations: {
                            if weakSelf.state == .mistake {
                                weakSelf.tryAgainButton.alpha = 1
                                weakSelf.resultLabel.text = "Mistake\nTry again"
                                weakSelf.tryAgainButton.alpha = 1
                            }else{
                                weakSelf.resultLabel.text = "It is right"
                            }
                            for view in [weakSelf.question1Label,
                                         weakSelf.question2Label,
                                         weakSelf.question1TextField,
                                         weakSelf.question2TextField,
                                         weakSelf.titleLabel,
                                         weakSelf.checkButton] {
                                            view.alpha = 0
                            }
                            for view in [weakSelf.resultLabel] {
                                            view.alpha = 1
                            }
            },
                           completion: nil)
        }
    }
    
}

extension SeveralTextFieldsAlertView: DTAlertViewProtocol {
    
    public func backgroundPressed() {
        if question1TextField.isFirstResponder {
            question1TextField.resignFirstResponder()
        }else if question2TextField.isFirstResponder {
            question2TextField.resignFirstResponder()
        }else{
            delegate?.dismiss()
        }
    }
    
}
