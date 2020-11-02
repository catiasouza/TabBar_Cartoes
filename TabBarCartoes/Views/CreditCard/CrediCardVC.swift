//
//  ViewController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/10/20.
//

import UIKit

class CrediCardVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    private var cartoes: Cartoes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.register(UINib(nibName: "CreditCardContainerCell", bundle: nil), forCellReuseIdentifier: "CreditCardContainerCell")
        self.cartoes = self.loadCrediCard()
        
        if self.cartoes != nil {
            self.tableview.delegate = self
            self.tableview.dataSource = self
        }
       print("FirstVC----viewDidLoad")
        self.tableview.tableFooterView = UIView()
    }

    @IBAction func tappedPerfilItem(_ sender: UIBarButtonItem) {
        print("***** perfil item button ****")
    }
    
    private func loadCrediCard() -> Cartoes?{
        
        if let path = Bundle.main.path(forResource: "cartoes", ofType: "json"){
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let cartoes = try JSONDecoder().decode(Cartoes.self, from: data)
                
                print("====>> Movimentacao \(cartoes)")
                return cartoes
            }catch{
                print("=== >>>> Deu ruim no parse")
                return nil
            }
        }
        return nil
    }
}

extension CrediCardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CreditCardContainerCell? = tableview.dequeueReusableCell(withIdentifier: "CreditCardContainerCell", for: indexPath) as? CreditCardContainerCell
        cell?.setup(value: self.cartoes, delegate: self)
        
        return cell ?? UITableViewCell()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc: InvoiceVC? = segue.destination as? InvoiceVC
        vc?.carId = sender as? String
    }
    
}
extension CrediCardVC : CreditCardContainerCellDelegate{
    func tappedCreditCard(withID: String) {
        print("credi===> \(withID)")
        self.performSegue(withIdentifier: "InvoiceVC", sender: withID)
    }
}
