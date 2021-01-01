//
//  CrediCardController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 14/11/20.
//

import Foundation

class CrediCardController {
    private var cartoes: Cartoes?
    private var isReloadCollection: Bool = false
    
    func loadCrediCard(completionHandler: @escaping(_ result: Bool, _ error: String?) -> Void){
        
        CartoesWorker().getCartoes { (success, error) in
            
            if let _success = success{
                
                self.cartoes = _success
                completionHandler(true, nil)
            }else{
                completionHandler(false, error)
            }
        }
//        if let path = Bundle.main.path(forResource: "cartoes", ofType: "json"){
//
//            do{
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//
//                let cartoes = try JSONDecoder().decode(Cartoes.self, from: data)
//
//                print("====>> Movimentacao \(cartoes)")
//                self.cartoes = cartoes
//                completionHandler(true, nil)
//            }catch{
//                print("=== >>>> Deu ruim no parse")
//                completionHandler(false, error)
//            }
//        }
    }
    var loadCartoes: Cartoes?{
        return self.cartoes
    }
    var numberOfRows: Int{
        return 1
    }
    func appendCreditCard(value: CartoesElement?){
        if let _value = value {
            self.cartoes?.cartoes.append(_value)
            self.isReloadCollection = true
        }
    }
    var reloadCreditCards: Bool {
        return self.isReloadCollection
    }
}
