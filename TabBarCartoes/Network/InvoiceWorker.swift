//
//  InvoiceWorker.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/12/20.
//

import Foundation
import Alamofire

class InvoiceWorker: GenericWorker {
    
    
    func getInvoice(cardId: String, completion: @escaping completion<CardListElement?>){
        
        //http://amock.io/ site da api
        
        let url: URL? = URL(string: "https://api.mocki.io/v1/49f4d97c")
        
        if let _url = url {
            
            var urlRequest = URLRequest(url: _url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            
            AF.request(urlRequest).responseJSON { (response) in
                
                print(response.response )
                
                if response.response?.statusCode == 200 {
                    
                    do {
                        let cardList = try JSONDecoder().decode(CardList.self, from: response.data ?? Data())
                        print(cardList.cardList?.first)
                        
                        if let _cardList = cardList.cardList {
                            
                            let cardListElement = _cardList.filter({$0.cardID == cardId})
                            
                            completion(cardListElement.first, nil)
                            
                        }else {
                            completion(nil, "Deu rui card id")
                            print("Deu ruim =======")
                        }
                        
                    }catch{
                        completion(nil, "deu ruim no cath")
                        print(error)
                    }
                }
            }
        }
    }
    
    //    func getInvoice(cardId: String, completion: @escaping completion<CardList?>){
    //
    //        let session: URLSession = URLSession.shared
    //        let url: URL? = URL(string: "http://www.amock.io/api/invoice")
    //
    //        if let _url = url {
    //            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
    //
    //                do {
    //                    let cardList = try JSONDecoder().decode(CardList.self, from: data ?? Data())
    //
    //                        completion(cardList, nil)
    //
    //                    }catch {
    //                        completion(nil, NSError())
    //                        print("Deu ruim =======")
    //                    }
    //                }
    //
    //            task.resume()
    //        }
    //
    //    }
}

