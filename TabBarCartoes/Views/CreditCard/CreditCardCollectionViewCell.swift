//
//  CreditCardCollectionViewCell.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 28/10/20.
//

import UIKit

class CreditCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contanierView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    //fazer image fundo
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func setup(value: CartoesElement?){
        if let _value = value{
            self.nameLabel.text = _value.nome
            self.numberLabel.text = _value.numero
            self.dateLabel.text = _value.data
            self.flagImage.image = UIImage(named: _value.bandeira)
            
            //self.cardBackground.image = UIImage(named: "fundo-visa"
            self.contanierView.layer.cornerRadius = 4
            
            if _value.bandeira == "mastercard"{
                self.contanierView.backgroundColor = .systemPink
                self.nameLabel.textColor = .white
                self.numberLabel.textColor = .white
                self.dateLabel.textColor = .white
                self.lineView.backgroundColor = .white
                //self.cardBackground.image = UIImage(named: "fundo-master"
            }
        }
    }
}
