//
//  SecondVC.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/10/20.
//

import UIKit


class AccountBalanceVC: UIViewController {
    
    @IBOutlet weak var timeLine: UITableView!
    
    private var controller: AccountBalanceController = AccountBalanceController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeLine.register(UINib(nibName: "ExtratoCell", bundle: nil), forCellReuseIdentifier: "ExtratoCell")
        
        self.controller.loadLancamentos()
        
        self.timeLine.delegate = self
        self.timeLine.dataSource = self
        self.timeLine.separatorStyle = .none
    }
    
}

extension AccountBalanceVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.controller.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ExtratoCell? = tableView.dequeueReusableCell(withIdentifier: "ExtratoCell", for: indexPath) as? ExtratoCell
        self.controller.loadCurrentLancamentoElement(index: indexPath.row)
        
        cell?.setup(value: self.controller.lancamentoElement)
        return cell ?? UITableViewCell()
    }
    
    
}
