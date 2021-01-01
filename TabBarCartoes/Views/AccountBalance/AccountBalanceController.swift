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
    private var worker: DespesasWorker = DespesasWorker()
    
    func loadCurrentLancamentoElement(index: Int){
        self.currentLancamentoElement = arrayLancamentos[index]
    }
    // PEGAR LOCALMENTE
    func loadLancamentos(completionHandler: @escaping(_ result: Bool, _ error: String?) -> Void) {
        self.worker.getLancamentos { (success, error) in
            if let _success = success{
                self.arrayLancamentos = _success
                completionHandler(true, nil)
            }else{
                completionHandler(false,"Ruim")
            }
        }
//
//        if let path = Bundle.main.path(forResource: "despesas", ofType: "json"){
//
//            do{
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//
//                let movimentacao = try JSONDecoder().decode(Movimentacao.self, from: data)
//
//                print("====>> Movimentacao \(movimentacao)")
//                self.arrayLancamentos =      movimentacao.lancamentos
//                completionHandler(true, nil)
//
//            }catch{
//                completionHandler(false, error)
//                print("=== >>>> Deu ruim no parse")
//            }
//        }
    }
    var numberOfRows: Int {
        return self.arrayLancamentos.count
    }
    var lancamentoElement: LancamentoElements?{
        return self.currentLancamentoElement
    }
    
}
