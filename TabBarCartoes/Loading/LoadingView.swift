//
//  LoadingView.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 27/12/20.
//

import UIKit
import Lottie

class LoadingView: UIView {
    @IBOutlet weak var animationLoadingView: AnimationView!

    func showLoading(){
        self.animationLoadingView.loopMode = .loop
        self.animationLoadingView.play()
    }
    
     func hiddenLoading(){
        self.animationLoadingView.stop()
        
    }
}
