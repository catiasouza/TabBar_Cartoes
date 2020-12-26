//
//  ViewController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/10/20.
//

import UIKit


class CrediCardVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var controller: CrediCardController = CrediCardController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.register(UINib(nibName: "CreditCardContainerCell", bundle: nil), forCellReuseIdentifier: "CreditCardContainerCell")
        
        self.controller.loadCrediCard { (result, error) in
            if result {
                self.tableview.delegate = self
                self.tableview.dataSource = self
                print("FirstVC----viewDidLoad")
                self.tableview.tableFooterView = UIView()
            }else {
                print("deu error:\(error)")
            }
        }
    }
    
    @IBAction func tappedPerfilItem(_ sender: UIBarButtonItem) {
        print("***** perfil item button ****")
    }
}

extension CrediCardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CreditCardContainerCell? = tableview.dequeueReusableCell(withIdentifier: "CreditCardContainerCell", for: indexPath) as? CreditCardContainerCell
        cell?.setup(value: self.controller.loadCartoes, delegate: self, isReload: self.controller.reloadCreditCards)
        
        return cell ?? UITableViewCell()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "InvoiceVC"{
            let vc: InvoiceVC? = segue.destination as? InvoiceVC
            vc?.setup(cardID: sender as? String)
        }else if segue.identifier == "AddCrediCardVC" {
            let vc : AddCrediCardVC? = segue.destination as? AddCrediCardVC
            vc?.delegate = self
        }
    }
}
extension CrediCardVC: AddCrediCardVCDelegate{
    
    func success(value: CartoesElement?) {
        print(value?.nome)
        self.controller.appendCreditCard(value: value)
        self.tableview.reloadData()
    }
}
extension CrediCardVC : CreditCardContainerCellDelegate{
    
    func tappedAddCrediCardbuttom() {
        self.performSegue(withIdentifier: "AddCrediCardVC", sender: nil)
    }
    
    func tappedCreditCard(withID: String) {
        print("credi===> \(withID)")
        self.performSegue(withIdentifier: "InvoiceVC", sender: withID)
    }
}
