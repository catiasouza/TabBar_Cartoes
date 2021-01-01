//
//  ErrorProtocolo.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 01/01/21.
//

import Foundation

protocol ErrorProtocolo: LocalizedError {
    var title: String? {get}
    var code: Int? {get}
}
struct ErrorHandle: ErrorProtocolo {
    var title: String?
    var code: Int?
    var errorDescription: String? {
        return _description
    }
    var failureReason: String? {return _description}
    
    private var _description: String?
    
    init(title: String?, description: String, code: Int?) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code ?? 400
    }
    init() {
        
    }
    init(dic: [String: Any]?) {
        
        if let _dic = dic {
            let dicResponse: [String: Any]? = _dic["response"] as? [String: Any]
            let dicBody: [String: Any]? = _dic["body"] as? [String: Any]
            
            if let _dicBody = dicBody {
                self.title = _dicBody["error"] as? String
                self._description = _dicBody["error_description"] as? String ?? ""
                self.code = dicResponse?["status"] as? Int
            }
        }
    }
}
