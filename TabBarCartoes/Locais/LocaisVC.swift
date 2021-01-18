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
        
        let initialLocation = CLLocation(latitude: -23.565163997932217, longitude: -46.652365089520536)
        
        self.centerMaponLocation(location: initialLocation)
       
        let agencia: Agencia = Agencia(title: "Trianon", subtitle: "Lugar turistico", categoria: "teste", lat: "-23.557665", lng: "-46.615526")
        
        self.maps.delegate = self
        self.maps.addAnnotation(agencia)
        
        
        if let locais = self.loadInitialData(){
            self.maps.addAnnotations(locais.agencias)
        }
        
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
    
    func loadInitialData() -> Locais?{
        if let path = Bundle.main.path(forResource: "Locais", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let local = try JSONDecoder().decode(Locais.self, from: data)
                return local
            }catch{
                
            }
        }
        return nil
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
extension LocaisVC: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Agencia else {return nil}
        
        let identifier = "marker"
        let view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            
            dequeuedView.annotation = annotation
            view = dequeuedView
        }else{
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "map-icon"), for: .normal)
            view.rightCalloutAccessoryView = mapsButton
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font.withSize(12)
            detailLabel.text = annotation.subtitle
            view.detailCalloutAccessoryView = detailLabel
            
       
        }
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailsViewController, let annotation: MKAnnotation = sender as? MKAnnotation {
            vc.annotationSelected = annotation
        }
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        print("\(view.annotation?.title) foi clicada")
        
        self.performSegue(withIdentifier: "DetailsViewController", sender: view.annotation)
    }
}


