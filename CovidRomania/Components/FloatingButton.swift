//
//  FloatingButton.swift
//  CovidRomania
//
//  Created by Radu Nitescu  on 21/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import Foundation
import UIKit

class FloatingButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required convenience init(img: String) {
        self.init()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 4
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        if let image = UIImage(named: img) {
            self.setImage(image, for: .normal)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override var isHighlighted :Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                self.backgroundColor = UIColor(red: 0.889, green: 0.889, blue: 0.892, alpha: 0.85)
            }
            else {
                self.backgroundColor = .white
            }
            super.isHighlighted = newValue
        }
    }
}
