//
//  BaseViewController.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/12/20.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func showError(error: ErrorHandle?){
        let alert = UIAlertController(title: error?.title, message: error?.errorDescription, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil)
    }

    func showLoading(){
        self.loadingView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? LoadingView
        self.loadingView?.frame = self.view.frame
        self.view.addSubview(self.loadingView ?? UIView())
        self.loadingView?.showLoading()
    }
    func hiddenLoading(){
        self.loadingView?.hiddenLoading()
        self.loadingView?.isHidden = true
    }

}
