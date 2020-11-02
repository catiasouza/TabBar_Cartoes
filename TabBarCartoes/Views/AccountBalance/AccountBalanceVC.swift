//
//  SecondVC.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/10/20.
//

import UIKit

class AccountBalanceVC: UIViewController {
    
    @IBOutlet weak var timeLine: UITableView!
    
  
    var arrayLancamentos:[LancamentoElements] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrayLancamentos = self.loadMovimentacoes() ?? []

        self.timeLine.register(UINib(nibName: "ExtratoCell", bundle: nil), forCellReuseIdentifier: "ExtratoCell")
      
        print("Second----viewDidLoad")
        self.timeLine.delegate = self
        self.timeLine.dataSource = self
        self.timeLine.separatorStyle = .none
        
    }
    
    private func loadMovimentacoes() -> [LancamentoElements]?{
        
        if let path = Bundle.main.path(forResource: "despesas", ofType: "json"){
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let movimentacao = try JSONDecoder().decode(Movimentacao.self, from: data)
                
                print("====>> Movimentacao \(movimentacao)")
                return movimentacao.lancamentos
            }catch{
                print("=== >>>> Deu ruim no parse")
                return nil
            }
        }
        return nil
    }
}

extension AccountBalanceVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayLancamentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ExtratoCell? = tableView.dequeueReusableCell(withIdentifier: "ExtratoCell", for: indexPath) as? ExtratoCell
        cell?.setup(value: self.arrayLancamentos[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}
