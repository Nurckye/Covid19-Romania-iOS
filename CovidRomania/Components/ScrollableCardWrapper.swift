//
//  ScrollableCardWrapper.swift
//  CovidRomania
//
//  Created by Radu Nitescu  on 19/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ScrollableCardWrapper: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required convenience init(county: CountyData) {
        self.init(frame: CGRect.zero)
        
        let cardWidth = 280
        let cardHeight = 40
        
        let scrollView: UIScrollView = {
            let v = UIScrollView()
            v.frame = self.bounds
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        self.addSubview(scrollView)

        
        let kpis = [
            InfoCard(key: "Numar total cazuri", value: String(county.totalCounty), color: UIColor(red: 0.286, green: 0.303, blue: 0.454, alpha: 1)),
            InfoCard(key: "Numar total decese", value: String(county.totalDead), color: UIColor(red: 0.633, green: 0.187, blue: 0.187, alpha: 1)),
            InfoCard(key: "Numar total vindecari", value: String(county.totalHealed), color: UIColor(red: 0.481, green: 0.567, blue: 0.238, alpha: 1)),
        ]
        
        var totalScrollElements = 0
        var prevKpi: InfoCard? = nil
        for kpi in kpis {
            scrollView.addSubview(kpi)
            if prevKpi == nil {
                kpi.snp.makeConstraints { make in
                    make.height.equalTo(cardHeight)
                    make.width.equalTo(cardWidth)
                    make.left.equalTo(scrollView).offset((Int(UIScreen.main.bounds.width) - cardWidth) / 2)
                }

            } else {
                kpi.snp.makeConstraints { make in
                    make.height.equalTo(cardHeight)
                    make.width.equalTo(cardWidth)
                    make.left.equalTo(prevKpi!.snp.right).offset(Int(UIScreen.main.bounds.width) - cardWidth)
                }
            }
            totalScrollElements += 1
            prevKpi = kpi
        }
        
        
        scrollView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(300)
        }
        
        scrollView.contentSize = CGSize(width: 3 * Int(UIScreen.main.bounds.width), height: 120)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
