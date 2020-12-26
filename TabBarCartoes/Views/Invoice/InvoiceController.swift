//
//  InvoiceController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 14/11/20.
//

import Foundation

class InvoiceController {
    private var cardListElement: CardListElement?
    private var cardID: String?
    
    init(cardListElement: CardListElement? = nil, cardID: String?) {
        self.cardID = cardID
        self.cardListElement = cardListElement
    }
    func loadCardListElent(completionHandler: (_ result: Bool, _ error: Error?) -> Void){
        
        if let path = Bundle.main.path(forResource: "invoice", ofType: "json"){
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let cardList = try JSONDecoder().decode(CardList.self, from: data)
                
                print("====>> cardlist \(cardList)")
                let list = cardList.cardList?.filter({$0.cardID == self.cardID ?? ""})
                
                self.cardListElement = list?.first
                completionHandler(true, nil)
            }catch{
                print("=== >>>> Deu ruim no parse")
                completionHandler(false, error)
                
            }
        }
    }
    var numberOfRows: Int {
        return self.cardListElement?.invoice?.count ?? 0
    }
    func loadCurrentInvoice(indexPath: Int) -> Invoice? {
        return self.cardListElement?.invoice?[indexPath]
    }
}
