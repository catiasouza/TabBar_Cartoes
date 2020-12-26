//
//  AddButtonCollectionCell.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 14/11/20.
//

import UIKit

protocol AddButtonCollectionCellDelegate: class {
    func tappedButton()
}
class AddButtonCollectionCell: UICollectionViewCell {
    
    weak var delegate: AddButtonCollectionCellDelegate?
    @IBOutlet weak var imageButton: UIImageView!
    @IBOutlet weak var backgroundViewButton: UIView!
    @IBOutlet weak var contanierView: UIView!
    @IBOutlet weak var imageCenter: UIImageView!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setup(delegate: AddButtonCollectionCellDelegate?){
        self.delegate = delegate
    }
    @IBAction func tappedbutton(_ sender: UIButton) {
        self.delegate?.tappedButton()
    }
}
