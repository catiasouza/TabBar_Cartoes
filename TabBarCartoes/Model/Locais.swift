//
//  Locais.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 11/01/21.
//

import Foundation
import MapKit


class Agencia: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var categoria: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?,subtitle: String?,categoria: String?,coordinate: CLLocationCoordinate2D){
        
        self.title = title
        self.subtitle = subtitle
        self.categoria = categoria
        self.coordinate = coordinate
        super.init()
    }
    init(json: [String: String]) {
        self.title = json["title"] ?? "No title"
        self.subtitle = json["subtitle"]
        self.categoria = json["categoria"]
        
        if let latitute = Double(json["lat"] ?? ""),
           let longitude = Double (json["lng"] ?? "") {
            self.coordinate = CLLocationCoordinate2D(latitude: latitute, longitude: longitude)
        }else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
}

