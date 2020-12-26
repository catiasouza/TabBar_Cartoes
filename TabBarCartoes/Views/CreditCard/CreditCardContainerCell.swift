//
//  CreditCardContainerCell.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 28/10/20.
//

import UIKit

protocol CreditCardContainerCellDelegate: class {
    
    func tappedCreditCard(withID: String)
    func tappedAddCrediCardbuttom()
}
class CreditCardContainerCell: UITableViewCell {
    
    weak var delegate: CreditCardContainerCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var cartoes: Cartoes?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setup(value: Cartoes?, delegate: CreditCardContainerCellDelegate?, isReload: Bool = false){
        
        self.collectionView.register(UINib(nibName: "CreditCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditCardCollectionViewCell")
        
        self.collectionView.register(UINib(nibName: "AddButtonCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AddButtonCollectionCell")
        
        self.cartoes = value
        self.delegate = delegate
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if isReload {
            self.collectionView.reloadData()
        }
        
    }
}
extension CreditCardContainerCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = self.cartoes?.cartoes.count ?? 0
        return count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CreditCardCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCardCollectionViewCell", for: indexPath) as? CreditCardCollectionViewCell
        if indexPath.row < cartoes?.cartoes.count ?? 0 {
            cell?.setup(value: cartoes?.cartoes[indexPath.row])
            return cell ?? UICollectionViewCell()
        }else{
            let cell: AddButtonCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "AddButtonCollectionCell", for: indexPath) as? AddButtonCollectionCell
            
            cell?.setup(delegate: self)
            
            return cell ?? UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("\(cartoes?.cartoes[indexPath.row].id)")
        
        if indexPath.row < cartoes?.cartoes.count ?? 0 {
            self.delegate?.tappedCreditCard(withID: cartoes?.cartoes[indexPath.row].id ?? "")
        }
    }
}
extension CreditCardContainerCell: AddButtonCollectionCellDelegate{
    func tappedButton() {
        print("CreditCardContainerCell =======> AddButtonCollectionCellDelegate =======> tappedButton")
        self.delegate?.tappedAddCrediCardbuttom()
    }
    
    
}
