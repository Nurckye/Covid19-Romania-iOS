//
//  CityData.swift
//  CovidRomania
//
//  Created by Radu Nitescu  on 19/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import Foundation
import MapKit

class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}

struct CountyData: Decodable {
    var countyCode: String
    var totalCounty: Int
    var totalHealed:Int
    var totalDead: Int
    var county: String
    
    func generateAnnotation (latitude: Double, longitude: Double) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = self.county
        annotation.subtitle = "\(totalCounty) cazuri"
        annotation.coordinate =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return annotation
    }
}

struct InformationWrapper: Decodable {
    var total: Int
    var data: [CountyData]
}

struct CovidAPIResult: Decodable {
    var data: InformationWrapper
}
