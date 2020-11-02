//
//  ExtratoCell.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/10/20.
//

import UIKit

class ExtratoCell: UITableViewCell {

    @IBOutlet weak var extratoImage: UIImageView!
    @IBOutlet weak var valuelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(value: Invoice?){
        if let _value = value{
            self.descriptionLabel.text = _value.nome
            self.valuelabel.text = "R$ \(String(format: "%2.f",_value.valor ?? 00))"
            
            if _value.tipo?.rawValue == "E"{
                
                //self.valuelabel.textColor = .green
                self.extratoImage.image = UIImage.init(systemName: "dollarsign.circle")
                self.extratoImage.tintColor = UIColor(rgb: 0xA3F7AB)
                
            }else{
                
                self.valuelabel.textColor = .red
                self.valuelabel.text = "R$ -\(String(format: "%2.f",_value.valor ?? 00))"
                self.extratoImage.image = UIImage.init(systemName: "dollarsign.circle")
                self.extratoImage.tintColor = .red
            }
        }
        
    }
    
    func setup(value: LancamentoElements?){
        if let _value = value{
            self.descriptionLabel.text = _value.nome
            self.valuelabel.text = "R$ \(String(format: "%2.f",_value.valor))"
            
            if _value.tipo == "E"{
                
                //self.valuelabel.textColor = .green
                self.extratoImage.image = UIImage.init(systemName: "dollarsign.circle")
                self.extratoImage.tintColor = UIColor(rgb: 0xA3F7AB)
                
            }else{
                
                self.valuelabel.textColor = .red
                self.valuelabel.text = "R$ -\(String(format: "%2.f",_value.valor))"
                self.extratoImage.image = UIImage.init(systemName: "dollarsign.circle")
                self.extratoImage.tintColor = .red
            }
        }
        
    }
    
}
extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
}
