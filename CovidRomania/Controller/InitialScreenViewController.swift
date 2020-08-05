//
//  InitialScreenViewController.swift
//  CovidRomania
//
//  Created by Radu Nitescu  on 19/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import UIKit
import SnapKit

class InitialScreenViewController: UIViewController {

    func fetchData(completionHandler: @escaping (CovidAPIResult) -> Void) {
      
        let url = URL(string: "https://covid19.geo-spatial.org/api/dashboard/getCasesByCounty")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
          
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let data = data,
                let todayData = try? decoder.decode(CovidAPIResult.self, from: data) {
                completionHandler(todayData)
            }
        })
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue

    
        self.fetchData(completionHandler: { [weak self] (data) in
            MapUtils.APIData = data.data
            MapUtils.APIData?.orderByTotalCases()
            DispatchQueue.main.async {
                self?.navigationController?.setViewControllers([MapViewController()], animated: true)
            }
        })
    }
}
