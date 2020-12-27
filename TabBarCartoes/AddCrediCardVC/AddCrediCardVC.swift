//
//  AddCrediCardVC.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 15/11/20.
//

import UIKit

enum DateEnum: Int {
    case month = 0
    case year = 1
}
protocol AddCrediCardVCDelegate: class {
    func success(value: CartoesElement?)
}

class AddCrediCardVC: UIViewController {
 
    var mes: String?
    var ano: String?
    weak var delegate: AddCrediCardVCDelegate?
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var numberCardLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var flagSegmentControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var phototButton: UIButton!
    //private var datePicker: UIDatePicker!
    private var controller : AddCreditCardController = AddCreditCardController()
    
    private var dateView: UIPickerView!
    private var months: [String] = Calendar.current.monthSymbols
    private var year: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTF.delegate = self
        self.numberCardLabel.delegate = self
        self.dateLabel.delegate = self
        
        configScreen()
        configDatepicker()
        loadYears()
        
    }
    private func loadYears(){
        let currentData = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year,from: currentData)
        self.year = (currentYear...2100).map {String($0)}
    }
    private func configDatepicker(){
        //self.datePicker = UIDatePicker()
        self.dateView = UIPickerView()
        //self.dateView.datePickerMode = .date
        self.dateView?.delegate = self
        self.dateView?.dataSource = self
        //self.datePicker.preferredDatePickerStyle = .wheels
        self.dateView?.backgroundColor = UIColor.red
        self.dateView?.setValue(UIColor.white, forKeyPath: "textColor")
        //let localizacao = Locale(identifier: "pt_BR")
        //self.datePicker.locale = localizacao
        self.dateLabel.inputView = self.dateView
       
        //let currentdate = Date()
//        self.datePicker.minimumDate = currentdate
//        self.datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 5, to: currentdate)
        
        self.confToobar()
        
    }
    private func confToobar(){
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = UIColor.black
        toolbar.backgroundColor = UIColor.red
        toolbar.sizeToFit()
        
        let cancelBotao = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelClick))
        //separar botao
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let pronto = UIBarButtonItem(title: "Pronto", style: .plain, target: self, action: #selector(doneClick))
        toolbar.setItems([cancelBotao,spaceButton, pronto], animated: false)
        toolbar.isUserInteractionEnabled = true
        self.dateLabel.inputAccessoryView = toolbar
    }
    @objc private func cancelClick(){
        self.dateLabel.resignFirstResponder()
    }
    @objc private func doneClick(){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        self.dateLabel.text = dateFormatter.string(from: self.datePicker.date)
        let monthSelected = self.dateView?.selectedRow(inComponent: 0) ?? 0
        let yearSelected = self.dateView?.selectedRow(inComponent: 1) ?? 0
        self.dateLabel.text = "\(self.months[monthSelected])/\(self.year[yearSelected] ?? "")"
        
        self.dateLabel.resignFirstResponder()
    }
    private func configScreen(){
        self.saveButton.layer.cornerRadius = 4
        self.phototButton.layer.cornerRadius = 4
        
        self.nameTF.layer.borderColor = UIColor.red.cgColor
        self.dateLabel.layer.borderColor = UIColor.red.cgColor
        self.numberCardLabel.layer.borderColor = UIColor.red.cgColor
        
        self.dateLabel.layer.borderWidth = 0.5
        self.numberCardLabel.layer.borderWidth = 0.5
        self.nameTF.layer.borderWidth = 0.5
        
        
    }
    @IBAction func tappedSelectFlag(_ sender: UISegmentedControl) {
    }
    
    @IBAction func tappedPhotoButton(_ sender: UIButton) {
       self.getImage(fromSourceType: .photoLibrary)
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        
        if self.checkFields(){
          
            let alert = UIAlertController(title: "Sucesso", message: "Deu certo 😬, cartão add com sucesso", preferredStyle: .alert)

            let button = UIAlertAction(title: "OK", style: .default) { (success) in

              
                self.controller.saveCrediCard(name: self.nameTF.text, date: self.dateLabel.text, number: self.numberCardLabel.text, flag: self.flagSegmentControl.selectedSegmentIndex)
                
                self.delegate?.success(value: self.controller.crediCardSaved)
                self.dismiss(animated: true, completion: nil)
            }

            alert.addAction(button)

            self.present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Alerta", message: "Vc precisa preeencher todos os campos", preferredStyle: .alert)
            
            let buttonOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(buttonOK)
            alert.addAction(buttonCancel)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkFields() -> Bool{
        
        if self.nameTF.text?.isEmpty ?? true{
            return false
        }else if numberCardLabel.text?.isEmpty ?? true{
            return false
        }else if self.dateLabel.text?.isEmpty ?? true{
            return false
        }else if self.flagSegmentControl.selectedSegmentIndex == -1{
            return false
        }
        return true
    }
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
}
extension AddCrediCardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let urlImage : NSURL? = info[UIImagePickerController.InfoKey.imageURL] as? NSURL
        print("URLImage:\(urlImage)")
        //print("=== \(info)")
        picker.dismiss(animated: true, completion: nil)
        
    }
}
extension AddCrediCardVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.nameTF:
            self.numberCardLabel.becomeFirstResponder()
        case self.numberCardLabel:
            self.dateLabel.becomeFirstResponder()
        case dateLabel:
            self.dateLabel.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
extension AddCrediCardVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == DateEnum.month.rawValue {
            return self.months.count
        }
        return self.year.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if component == DateEnum.month.rawValue {
            return months[row]
        }else{
            return year[row]
        }
    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
//       
//        if component == DateEnum.month.rawValue {
//            self.mes = self.months[row]
//            print(months[row])
//        }else {
//            self.ano = self.year[row]
//           print(year[row])
//        }
//    }
}
