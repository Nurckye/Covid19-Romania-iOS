//
//  MapUtils.swift
//  CovidRomania
//
//  Created by Radu Nitescu  on 19/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import Foundation
import MapKit


//TODO: "JUDEȚ NECUNOSCUT"
class MapUtils {
    static let countiesCoordinates = [
        "ILFOV": (latitude: 44.56297439999999, longitude: 25.9388214),
        "GIURGIU": (latitude: 43.8583495, longitude: 25.9065998),
        "GORJ": (latitude: 45.0278661, longitude: 23.2339778),
        "ARAD": (latitude: 46.0680466, longitude: 20.9569318),
        "CLUJ": (latitude: 46.4845372, longitude: 23.8602001),
        "BISTRITA-NASAUD": (latitude: 47.2921849, longitude: 24.3973258),
        "BRAȘOV": (latitude: 45.7644149, longitude: 24.930825),
        "ALBA": (latitude: 46.0906884, longitude: 23.2919452),
        "HARGHITA": (latitude: 46.3396282, longitude: 25.3796778),
        "MURES": (latitude: 46.4519038, longitude: 24.2607617),
        "BOTOȘANI": (latitude: 47.60334530000001, longitude: 27.2603068),
        "IALOMITA": (latitude: 44.6789472, longitude: 26.8495141),
        "BUCUREȘTI": (latitude: 44.4267674, longitude: 26.1025384),
        "TELEORMAN": (latitude: 43.97505719999999, longitude: 25.3282579),
        "BACAU": (latitude: 46.5670437, longitude: 26.9145748),
        "MARAMURES": (latitude: 47.6567387, longitude: 23.5849881),
        "BRAILA": (latitude: 45.2652463, longitude: 27.9594714),
        "BUZAU": (latitude: 45.1371109, longitude: 26.8171122),
        "CALARASI": (latitude: 44.2085144, longitude: 27.3137439),
        "CONSTANTA": (latitude: 44.1598013, longitude: 28.6348138),
        "DOLJ": (latitude: 44.3301785, longitude: 23.7948807),
        "HUNEDOARA": (latitude: 45.86625739999999, longitude: 22.9143737),
        "MEHEDINTI": (latitude: 44.6369227, longitude: 22.6597342),
        "VRANCEA": (latitude: 45.69647450000001, longitude: 27.184043),
        "GALAȚI": (latitude: 45.4353208, longitude: 28.0079945),
        "IAȘI": (latitude: 47.1584549, longitude: 27.6014418),
        "BIHOR": (latitude: 47.04650050000001, longitude: 21.9189438),
        "ARGEȘ": (latitude: 44.8564798, longitude: 24.8691824),
        "PRAHOVA": (latitude: 44.936664, longitude: 26.0128616),
        "VALCEA": (latitude: 45.0996753, longitude: 24.3693179),
        "SATU MARE": (latitude: 47.8016702, longitude: 22.8575926),
        "COVASNA": (latitude: 45.8609375, longitude: 25.7885796),
        "SIBIU": (latitude: 45.7983273, longitude: 24.1255826),
        "OLT": (latitude: 44.4301677, longitude: 24.3716904),
        "SUCEAVA": (latitude: 47.6634521, longitude: 26.2732302),
        "DÂMBOVIȚA": (latitude: 44.9118218, longitude: 25.4558274),
        "TIMIS": (latitude: 45.7488716, longitude: 21.2086793),
        "TULCEA": (latitude: 45.1716165, longitude: 28.7914439),
        "VASLUI": (latitude: 46.6406915, longitude: 27.7276468),
        "SALAJ": (latitude: 47.1854562, longitude: 23.0573324),
    ]
    
    static var countiesInfo: [String: CountyData] = [:]
    
    
    
    static var APIData: InformationWrapper? = nil

    static func generateCountiesCoordinates() -> [MKPointAnnotation] {
        var result:[MKPointAnnotation] = []
        
        guard let apiData = MapUtils.APIData else {
            return []
        }
        
        for countyData in apiData.data {
            guard let coordinates = MapUtils.countiesCoordinates[countyData.county] else {
                continue
            }
            MapUtils.countiesInfo[countyData.county] = countyData
            let annotation = countyData.generateAnnotation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            result.append(annotation)
        }
        
        return result
    }
}
