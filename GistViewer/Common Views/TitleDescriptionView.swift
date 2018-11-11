//
//  TitleDescriptionView.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 10/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Cartography

class TitleDescriptionView: UIView {
    
    let lblTitle: UILabel = UILabel()
    let lblDescription: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        
        lblTitle.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        lblTitle.textColor = UIColor.white
        lblTitle.textAlignment = .left
        
        lblDescription.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        lblDescription.textColor = UIColor.white
        lblDescription.textAlignment = .left
        lblDescription.numberOfLines = 0
        
        addSubview(lblTitle)
        addSubview(lblDescription)
        
        constrain(lblTitle, lblDescription) {
            lblTitle, lblDescription in
            if let superview = lblTitle.superview {
                lblTitle.top == superview.top
                lblTitle.leading == superview.leading + 8
                lblTitle.trailing == superview.trailing - 8
                
                lblDescription.top == lblTitle.bottom + 4
                lblDescription.bottom == superview.bottom
                lblDescription.leading == superview.leading + 8
                lblDescription.trailing == superview.trailing - 8
            }
        }
    }
}
