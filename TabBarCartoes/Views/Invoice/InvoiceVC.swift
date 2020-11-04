//
//  InvoiceVC.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 28/10/20.
//
// TESTE ******
import UIKit

class InvoiceVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var carId: String?
    private var cardListElement: CardListElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ExtratoCell", bundle: nil), forCellReuseIdentifier: "ExtratoCell")
        self.cardListElement = self.loadCardListElent()
        print("cardId")
        if self.cardListElement != nil{
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    private func loadCardListElent() -> CardListElement?{
        
        if let path = Bundle.main.path(forResource: "invoice", ofType: "json"){
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let cardList = try JSONDecoder().decode(CardList.self, from: data)
                
                print("====>> cardlist \(cardList)")
                let list = cardList.cardList?.filter({$0.cardID == self.carId ?? ""})
                
                return list?.first
            }catch{
                print("=== >>>> Deu ruim no parse")
                return nil
            }
        }
        return nil
    }

}
extension InvoiceVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardListElement?.invoice?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ExtratoCell? = tableView.dequeueReusableCell(withIdentifier: "ExtratoCell",for: indexPath) as? ExtratoCell
       // cell?.setup(value: self.cardList)
        cell?.setup(value: self.cardListElement?.invoice?[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}
