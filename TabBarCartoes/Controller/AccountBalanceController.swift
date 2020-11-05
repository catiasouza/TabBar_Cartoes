//
//  AccountBalanceController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 04/11/20.
//
import Foundation
class AccountBalanceController{
    
    private var arrayLancamentos:[LancamentoElements] = []
    private var currentLancamentoElement: LancamentoElements?
    
    func loadCurrentLancamentoElement(index: Int){
        self.currentLancamentoElement = arrayLancamentos[index]
    }
    
    func loadLancamentos() {
        
        if let path = Bundle.main.path(forResource: "despesas", ofType: "json"){
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let movimentacao = try JSONDecoder().decode(Movimentacao.self, from: data)
                
                print("====>> Movimentacao \(movimentacao)")
                self.arrayLancamentos =      movimentacao.lancamentos
            }catch{
                print("=== >>>> Deu ruim no parse")
            }
        }
    }
    var numberOfRows: Int {
        return self.arrayLancamentos.count
    }
    var lancamentoElement: LancamentoElements?{
        return self.currentLancamentoElement
    }
    
}
