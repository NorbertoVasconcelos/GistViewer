//
//  GistTableViewCell.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Domain
import Cartography
import Kingfisher

class GistTableViewCell: UITableViewCell {
    
    var container: UIView = UIView()
    var owner: ImageTitleView = ImageTitleView()
    var lblText: UILabel = UILabel()
    var lblNumComments: UILabel = UILabel()
    var lblDate: UILabel = UILabel()
    
    func bind(_ viewModel: Gist) {
        backgroundColor = UIColor.clear
        
        container.layer.cornerRadius = 8
        container.layer.masksToBounds = true
        container.backgroundColor = UIColor.white
        
        if let url = URL(string: viewModel.owner.avatarUrl) {
            owner.imgView.kf.setImage(with: url)
        }
        owner.lblTitle.text = viewModel.owner.username
        owner.lblTitle.textColor = UIColor.black
        
        lblText.text = viewModel.description
        lblText.numberOfLines = 3
        lblText.font = UIFont(name: "HelveticaNeue-Regular", size: 16.0)
        lblText.textAlignment = .left
        
        lblNumComments.text = "Comments: \(viewModel.numberOfComments)"
        lblNumComments.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        lblNumComments.textAlignment = .right
        
        lblDate.text = viewModel.createdAt?.simpleString
        lblDate.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        lblDate.textAlignment = .right
        
        addSubview(container)
        container.addSubview(lblText)
        container.addSubview(lblNumComments)
        container.addSubview(lblDate)
        container.addSubview(owner)
        
        constrain(container) {
            if let superview = $0.superview {
                $0.top == superview.top + 8
                $0.bottom == superview.bottom - 8
                $0.leading == superview.leading + 8
                $0.trailing == superview.trailing - 8
            }
        }
        
        constrain(owner, lblText) {
            owner, lblText in
            if let containerSuperview = owner.superview {
                owner.width == 90
                owner.top == containerSuperview.top
                owner.bottom == containerSuperview.bottom
                owner.leading == containerSuperview.leading
            }
        }
        
        constrain(owner, lblText, lblDate, lblNumComments) {
            owner, lblText, lblDate, lblComments in
            if let superview = lblText.superview {
                lblText.top == lblDate.bottom + 8
                lblText.bottom <= lblComments.top - 8 ~ UILayoutPriority(1000)
                lblText.leading == owner.trailing + 8
                lblText.trailing == superview.trailing - 8
                
                lblDate.top == superview.top + 8
                lblDate.trailing == superview.trailing - 8
                
                lblComments.bottom == superview.bottom - 8
                lblComments.trailing == superview.trailing - 8
            }
        }
    }

}
