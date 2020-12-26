//
//  AddCreditCardController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 26/12/20.
//

import Foundation

class AddCreditCardController {
    
    private var crediCard: CartoesElement?
    
    func saveCrediCard(name: String?, date: String?, number: String?, flag: Int?) {
        
        let card: CartoesElement? = CartoesElement(id: String(Int.random(in: 1...1000)), nome: name ?? "", data: date ?? "", numero: number ?? "", bandeira: Flag.loadFlag(index: flag ?? 3).rawValue)
        
        self.crediCard = card
    }
    var crediCardSaved: CartoesElement? {
        return self.crediCard
    }
}
