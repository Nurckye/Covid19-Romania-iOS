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
                    make.width.equalTo(InfoCard.cardWidth)
                    make.left.equalTo(scrollView).offset(24)
                }

            } else {
                kpi.snp.makeConstraints { make in
                    make.height.equalTo(cardHeight)
                    make.width.equalTo(InfoCard.cardWidth)
                    make.left.equalTo(prevKpi!.snp.right).offset(24)
                }
            }
            totalScrollElements += 1
            prevKpi = kpi
        }
        
        scrollView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(300)
        }

        scrollView.contentSize = CGSize(width: 3 * (InfoCard.cardWidth + 24) + 24, height: 120)
        
        let dragBar:UIView = {
                   let vw = UIView()
                   vw.backgroundColor = UIColor(red: 0.442, green: 0.418, blue: 0.396, alpha: 0.47)
                   vw.layer.cornerRadius = 6
                   return vw
        }()
        self.addSubview(dragBar)
        dragBar.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.snp.top).offset(-14)
            make.centerX.equalTo(self.snp.left).offset(UIScreen.main.bounds.width / 2)
            make.width.equalTo(72)
            make.height.equalTo(10)
        }
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
