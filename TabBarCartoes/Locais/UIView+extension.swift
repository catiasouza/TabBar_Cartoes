//
//  UIView+extension.swift
//  TabBarCartoes
//
//  Created by Cátia Souza on 18/01/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addBlurEffect() {
        
        //so funciona no IPHONE
//            let blurEffect = UIBlurEffect(style: .extraLight)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            blurEffectView.frame = self.bounds
//            blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//
//            self.addSubview(blurEffectView)

    }
//    func addBlueEffect(style: UIBlurEffect.Style) {
//        let blurEffect = UIBlurEffect(style: style)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.bounds
//        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//
//        self.addSubview(blurEffectView)
//    }
    func removeBlurEffect()  {
        for subView in self.subviews {
            if subView is UIVisualEffect {
                subView.removeFromSuperview()
            }
        }
    }
}
