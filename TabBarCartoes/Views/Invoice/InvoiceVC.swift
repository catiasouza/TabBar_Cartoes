//
//  InvoiceVC.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 28/10/20.
//


import UIKit


class InvoiceVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
   
    private var controller: InvoiceController?
    //var cardID: String?
    
    func setup(cardID: String?){
        self.controller = InvoiceController(cardID: cardID)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ExtratoCell", bundle: nil), forCellReuseIdentifier: "ExtratoCell")
        self.showLoading()
        
        self.controller?.loadCardListElent(completionHandler: { (result, error) in
            
            if result {
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    self.hiddenLoading()
                }
            }else {
                DispatchQueue.main.async {
                    print("Deu error \(error)")
                    self.hiddenLoading()
                }
                
            }
        })
        
    }
}
extension InvoiceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ExtratoCell? = tableView.dequeueReusableCell(withIdentifier: "ExtratoCell",for: indexPath) as? ExtratoCell
        cell?.setup(value: self.controller?.loadCurrentInvoice(indexPath: indexPath.row))
        return cell ?? UITableViewCell()
    }
  
}
