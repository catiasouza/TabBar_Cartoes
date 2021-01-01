//
//  CartoesWorker.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 01/01/21.
//

import Foundation

class CartoesWorker: GenericWorker {
    
    func getCartoes(completion: @escaping completion<Cartoes?>){
        
        let session: URLSession = URLSession.shared
        
        //http://amock.io/ site da api
        
        let url: URL? = URL(string: "https://api.mocki.io/v1/5b712c8d")
        
        if let _url = url {
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
                
                do{
                    let cartoes = try JSONDecoder().decode(Cartoes.self, from: data ?? Data())
                    completion(cartoes,nil)
                }catch{
                    completion(nil,"Deu ruim no cartoes")
                }
            }
            task.resume()
        }
    }
}
