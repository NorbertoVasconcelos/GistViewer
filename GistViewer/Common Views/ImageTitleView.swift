//
//  ImageTitleView.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 10/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Cartography

class ImageTitleView: UIView {
    
    let lblTitle: UILabel = UILabel()
    let imgView: UIImageView = UIImageView(image: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 8
        imgView.layer.masksToBounds = true
        
        lblTitle.numberOfLines = 0
        lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        lblTitle.textColor = UIColor.white
        lblTitle.textAlignment = .center
        
        addSubview(lblTitle)
        addSubview(imgView)
        
        constrain(lblTitle, imgView) {
            lblTitle, imgView in
            if let superview = imgView.superview {
                imgView.centerX == superview.centerX
                imgView.width == 80
                imgView.height == 80
                imgView.top == superview.top + 8
                imgView.bottom == lblTitle.top - 8
                
                lblTitle.leading == superview.leading + 8
                lblTitle.trailing == superview.trailing - 8
                lblTitle.bottom == superview.bottom - 8
            }
        }
    }
}
