//
//  Invoice.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 28/10/20.
//

import Foundation

struct CardList: Codable {
    var cardList:[CardListElement]?
}
struct CardListElement: Codable {
    var cardID: String?
    var invoice: [Invoice]?
}
struct Invoice: Codable {
    var id, nome: String?
    var data: String?
    var valor: Double?
    var tipo: Tipo?
}
enum Tipo: String, Codable {
    case e = "E"
    case s = "S"
    
}
