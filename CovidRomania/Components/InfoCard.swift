//
//  InfoCardView.swift
//  CovidRomania
//
//  Created by Radu Nitescu  on 19/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import UIKit
import SnapKit

class InfoCard: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required convenience init(key: String, value: String, color: UIColor) {
        self.init(frame: CGRect.zero)
        let cornerRadiusValue:CGFloat = 8
        let boxContainer: UIView = UIView()
        boxContainer.layer.cornerRadius = cornerRadiusValue
        boxContainer.layer.shadowColor = UIColor.black.cgColor
        boxContainer.layer.shadowOpacity = 0.25
        boxContainer.layer.shadowOffset = .zero
        boxContainer.layer.shadowRadius = 4
        boxContainer.backgroundColor = color
        
        let keyLabel = UILabel()
        keyLabel.text = key
        keyLabel.textColor = .white
        keyLabel.font = UIFont(name: "Helvetica", size: 20.0)
        boxContainer.addSubview(keyLabel)
        keyLabel.snp.makeConstraints { make in
            make.top.equalTo(boxContainer.snp.top).offset(36)
            make.centerX.equalTo(boxContainer)
            make.height.equalTo(20)
        }
        
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = UIFont(name: "Helvetica-Bold", size: 50.0)
        boxContainer.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(boxContainer)
            make.centerY.equalTo(boxContainer).offset(18)
        }
        
        boxContainer.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(160)
        }
    
        
        self.addSubview(boxContainer)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
