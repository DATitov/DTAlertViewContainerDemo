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
    
    public var requiredHeight: CGFloat = 120
    public var frameToFocus: CGRect = .zero
    public var needToFocus: Bool = false
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "DBMS_Logo_20")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        let attributes = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 14),
            NSForegroundColorAttributeName : UIColor(white: 0.3, alpha: 0.9)
            ] as [String : Any]
        label.attributedText = NSAttributedString(string: "DBMS", attributes: attributes)
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        let attributes = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 12),
            NSForegroundColorAttributeName : UIColor(white: 0.4, alpha: 0.9)
            ] as [String : Any]
        label.textAlignment = .right
        label.attributedText = NSAttributedString(string: "2 sec ago", attributes: attributes)
        return label
    }()
    let messageTitleLabel: UILabel = {
        let label = UILabel()
        let attributes = [
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15),
            NSForegroundColorAttributeName : UIColor.black
            ] as [String : Any]
        label.attributedText = NSAttributedString(string: "Student", attributes: attributes)
        return label
    }()
    let messageLabel: UILabel = {
        let label = UILabel()
        let attributes = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 14),
            NSForegroundColorAttributeName : UIColor.black
            ] as [String : Any]
        label.attributedText = NSAttributedString(string: "Complete creating the \"Student\" entity!", attributes: attributes)
        return label
    }()
    let backgroundView = NotificationBackgroundView()
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
        self.addSubview(backgroundView)
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        self.addSubview(timeLabel)
        self.addSubview(messageTitleLabel)
        self.addSubview(messageLabel)
    }

}

extension NotificationAlertView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let verticalOffset = 25.0 as CGFloat
        backgroundView.frame = CGRect(x: 0, y: verticalOffset, width: self.frame.size.width, height: self.frame.size.height - verticalOffset)
        
        let logoSize = CGSize(width: 20, height: 20)
        let headerHeight = backgroundView.headerHeight
        let logoIVHorisontalOffset: CGFloat = 7
        let labelsHorisontalOffset: CGFloat = 7
        let labelsWidth = (frame.size.width - logoIVHorisontalOffset - labelsHorisontalOffset * 2 - logoSize.width) / 2
        logoImageView.frame = CGRect(x: logoIVHorisontalOffset, y: verticalOffset + (headerHeight - logoSize.height) / 2,
                                     width: logoSize.width, height: logoSize.height)
        titleLabel.frame = CGRect(x: logoIVHorisontalOffset + labelsHorisontalOffset + logoSize.width, y: verticalOffset,
                                  width: labelsWidth, height: headerHeight)
        timeLabel.frame = CGRect(x: frame.size.width - labelsWidth - labelsHorisontalOffset, y: verticalOffset,
                                 width: labelsWidth, height: headerHeight)
        
        let messageLabelsHorisontalOffset: CGFloat = 15
        let messageCenterY: CGFloat = verticalOffset + headerHeight + (frame.size.height - verticalOffset - headerHeight) / 2
        let messageHeight = (frame.size.height - verticalOffset - headerHeight)
        messageTitleLabel.frame = CGRect(x: messageLabelsHorisontalOffset, y: messageCenterY - messageHeight / 2,
                                         width: frame.size.width - messageLabelsHorisontalOffset * 2, height: messageHeight / 2)
        messageLabel.frame = CGRect(x: messageLabelsHorisontalOffset, y: messageCenterY - 5,
                                         width: frame.size.width - messageLabelsHorisontalOffset * 2, height: messageHeight / 2)
    }
}

extension NotificationAlertView: DTAlertViewProtocol {
        
    public func backgroundPressed() {
        delegate.dismiss()
    }
    
}
