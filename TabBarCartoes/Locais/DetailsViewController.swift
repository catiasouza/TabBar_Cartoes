//
//  DetailsViewController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 15/01/21.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    var annotationSelected: MKAnnotation?
    
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var latlabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var titleDetails: UILabel!
    @IBOutlet weak var viewDetails: UIView!//backgroudViewLocal
    @IBOutlet weak var imageViewDetails: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
      
    }
    
    private func setup(){
        
        if let _annotation = self.annotationSelected{
            self.titleDetails.text = _annotation.title ?? ""
            self.subTitle.text = _annotation.subtitle ?? ""
            self.latlabel.text = "latitude:\(annotationSelected?.coordinate.latitude ?? 0)"
            self.lonLabel.text = "longitude:\(annotationSelected?.coordinate.longitude ?? 0)"
            self.imageViewDetails.image = UIImage(named: (_annotation.title ?? "") ?? "")
            
//            self.imageViewDetails.addBlurEffect()
//            self.latlabel.addBlueEffect(style: .extraLight)
            
        }
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 5) {
            self.imageViewDetails.removeBlurEffect()
        }
    }
   
}
