//
//  AccountBalanceController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 04/11/20.
//
import Foundation
class AccountBalanceController {
    
    private var arrayLancamentos:[LancamentoElements] = []
    private var currentLancamentoElement: LancamentoElements?
    
    func loadCurrentLancamentoElement(index: Int){
        self.currentLancamentoElement = arrayLancamentos[index]
    }
    
    func loadLancamentos(completionHandler: (_ result: Bool, _ Error: Error?) -> Void) {
        
        if let path = Bundle.main.path(forResource: "despesas", ofType: "json"){
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let movimentacao = try JSONDecoder().decode(Movimentacao.self, from: data)
                
                print("====>> Movimentacao \(movimentacao)")
                self.arrayLancamentos =      movimentacao.lancamentos
                completionHandler(true, nil)
                
            }catch{
                completionHandler(false, error)
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
