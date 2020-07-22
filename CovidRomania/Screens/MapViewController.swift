//
//  MapViewController.swift
//  Project1
//
//  Created by Radu Nitescu  on 19/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import UIKit
import MapKit
import Foundation

class MapViewController: UIViewController, MKMapViewDelegate {
    var window: UIWindow?
    var mapView: MKMapView?
    var infoBoxes: ScrollableCardWrapper?
    var panGesture = UIPanGestureRecognizer()
    var originalCenter: CGPoint?
    var gesture: UIGestureRecognizer?
    
    @objc func statsPressed() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        let vc = ModalStatsViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func gridPressed() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        let vc = TableCasesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func animateInfoOut() {
        guard let iboxes = self.infoBoxes, let originalCenter = self.originalCenter else {
            return
        }
        iboxes.removeGestureRecognizer(self.gesture!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.infoBoxes!.center.y = 700
        }) { _ in
            self.infoBoxes?.removeFromSuperview()
        }
        
    }
    
    func bringBackUp() {
        
    }
    
    @objc func draggedView(_ sender: UIPanGestureRecognizer){
        guard let iboxes = self.infoBoxes, let originalCenter = self.originalCenter else {
            return
        }
        
        let translation = sender.translation(in: self.view)
//        print(iboxes.center.y + translation.y, originalCenter.y)
        if iboxes.center.y + translation.y > 495 {
            infoBoxes!.center = CGPoint(x: iboxes.center.x, y: iboxes.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
            if iboxes.center.y + translation.y > 580 {
                iboxes.isUserInteractionEnabled = false
                if self.gesture != nil  {
                    self.animateInfoOut()
                }
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        if self.infoBoxes != nil {
            self.infoBoxes?.removeFromSuperview()
        }
        if let _ = view.annotation, let title = view.annotation?.title {
            self.infoBoxes = ScrollableCardWrapper(county: MapUtils.countiesInfo[title!]!)
            self.view.addSubview(self.infoBoxes!)
            self.infoBoxes!.snp.makeConstraints { make in
                make.bottom.equalTo(self.view.snp.bottom).offset(-60)
                make.height.equalTo(120)
                make.width.equalTo(UIScreen.main.bounds.width)
                make.left.equalTo(self.view)
            }
            
            self.infoBoxes!.center.y = 700
            UIView.animate(withDuration: 0.6) {
                self.infoBoxes!.center.y = 300
            }

            panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView))
            self.gesture = panGesture
            self.infoBoxes!.isUserInteractionEnabled = true
            self.infoBoxes!.addGestureRecognizer(panGesture)
            self.originalCenter = self.infoBoxes!.center
            print(self.infoBoxes!.center)
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: (self.window?.frame.height)!))
        self.view.addSubview(self.mapView!)
        
        self.mapView?.isRotateEnabled = false
        self.mapView?.delegate = self

        
        for annotation in MapUtils.generateCountiesCoordinates() {
            mapView?.addAnnotation(annotation)
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: 45.397, longitude: 24.9632)
        let region = self.mapView?.regionThatFits(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1450000, longitudinalMeters: 145000))
        self.mapView?.setRegion(region!, animated: true)
        
        
        let statsButton = FloatingButton(img: "stats-icon")
        statsButton.addTarget(self, action: #selector(statsPressed), for: .touchUpInside)
        self.view.addSubview(statsButton)
        statsButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(60)
            make.right.equalTo(self.view.snp.right).offset(-24)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
        
        let gridButton = FloatingButton(img: "grid-icon")
        gridButton.addTarget(self, action: #selector(gridPressed), for: .touchUpInside)
        self.view.addSubview(gridButton)
        gridButton.snp.makeConstraints { make in
            make.top.equalTo(statsButton.snp.bottom).offset(24)
            make.right.equalTo(statsButton.snp.right)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
        
        let infoButton = FloatingButton(img: "question-icon")
        self.view.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(gridButton.snp.bottom).offset(24)
            make.right.equalTo(statsButton.snp.right)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
    }
}
