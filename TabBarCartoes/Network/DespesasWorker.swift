//
//  DespesasWorker.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 01/01/21.
//

import Foundation

class DespesasWorker: GenericWorker {
    
    func getDespesas(completion: @escaping completion<Movimentacao?>){
        let session: URLSession = URLSession.shared
        
        //http://amock.io/ site da api
        
        let url: URL? = URL(string: "api.mocki.io/v1/bdf1c7da")
        
        if let _url = url {
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
                
                do{
                    let despesas = try JSONDecoder().decode(Movimentacao.self, from: data ?? Data())
                    completion(despesas,nil)
                }catch{
                    completion(nil,"Despesas deu ruim")
                }
            }
            task.resume()
        }
    }
    
    
    func getLancamentos(completion: @escaping completion<[LancamentoElements]?>){
        
        let session: URLSession = URLSession.shared
        
        //http://amock.io/ site da api
        
        let url: URL? = URL(string: "https://api.mocki.io/v1/bdf1c7da")
        
        if let _url = url {
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
                
                do{
                    let despesas = try JSONDecoder().decode(Movimentacao.self, from: data ?? Data())
                    completion(despesas.lancamentos,nil)
                }catch{
                    completion(nil,"Deu ruim nos lancamentos")
                }
            }
            task.resume()
        }
    }
}
