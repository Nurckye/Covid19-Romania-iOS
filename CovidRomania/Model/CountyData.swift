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
    
    mutating func orderByTotalCases() -> Void {
        self.data = self.data.sorted { $0.totalCounty > $1.totalCounty }
    }
}

struct CovidAPIResult: Decodable {
    var data: InformationWrapper
}
