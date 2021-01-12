//
//  LocaisVC.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 11/01/21.
//

import UIKit
import MapKit

class LocaisVC: BaseViewController {
    
    @IBOutlet weak var maps: MKMapView!
    let regionRadius : CLLocationDistance = 1000
    
    //me arrumo p sair
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")

        let initialLocation = CLLocation(latitude: -23.557665, longitude: -46.615526)
        
        self.centerMaponLocation(location: initialLocation)
        
        let agencia: Agencia = Agencia(title: "Itau", subtitle: "CTO", categoria: "banco", coordinate: CLLocationCoordinate2D(latitude: -23.557665, longitude: -46.615526))
        
        self.maps.addAnnotation(agencia)
        
    }
    
    func centerMaponLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: self.regionRadius, longitudinalMeters: self.regionRadius)
        self.maps.setRegion(coordinateRegion, animated: true)
    }
    
    let locationManager = CLLocationManager()
    
    func checkLocationAutorizationStatus() {
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.maps.showsUserLocation = true
        }else {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    // sai
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewdidaper")
        self.checkLocationAutorizationStatus()
    }
}
extension LocaisVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.checkLocationAutorizationStatus()
    }
}
