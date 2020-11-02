//
//  CreditCardContainerCell.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 28/10/20.
//

import UIKit

protocol CreditCardContainerCellDelegate: class {
    
    func tappedCreditCard(withID: String)
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
    func setup(value: Cartoes?, delegate: CreditCardContainerCellDelegate?){
        
        self.collectionView.register(UINib(nibName: "CreditCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditCardCollectionViewCell")
        self.cartoes = value
        self.delegate = delegate
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
extension CreditCardContainerCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.cartoes?.cartoes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CreditCardCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCardCollectionViewCell", for: indexPath) as? CreditCardCollectionViewCell
        cell?.setup(value: cartoes?.cartoes[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.tappedCreditCard(withID: cartoes?.cartoes[indexPath.row].id ?? "")
    }
    
}
