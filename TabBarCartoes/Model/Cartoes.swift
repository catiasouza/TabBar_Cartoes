//
//  Cartoes.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 28/10/20.
//

import Foundation

struct Cartoes:Codable {
    
    let cartoes:[CartoesElement]
}
struct CartoesElement: Codable {
    let id, nome, data, numero, bandeira: String
}
