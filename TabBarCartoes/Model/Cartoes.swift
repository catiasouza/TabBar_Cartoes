//
//  Cartoes.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 28/10/20.
//

import Foundation

enum Flag: String {
    case mastercard = "mastercard"
    case visa = "visa"
    case elo = "elo"
    case none = "outros"
   
    static func loadFlag(index: Int) -> Flag {
        switch index {
        case 0:
            return .mastercard
        case 1:
            return .visa
        case 2:
            return .elo
        default:break
        }
        return .none
    }
}
struct Cartoes: Codable {
    
    var cartoes:[CartoesElement]
}
struct CartoesElement: Codable {
    let id, nome, data, numero, bandeira: String
}
