//
//  Movimentacao.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/10/20.
//

import Foundation

struct Movimentacao: Codable {
    
    let lancamentos:[LancamentoElements]
}

struct LancamentoElements: Codable {
    let id,nome, data, tipo: String
    let valor: Float
}
