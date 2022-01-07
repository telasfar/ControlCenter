//
//  AnimatorFactory.swift
//  BodyBuildTask
//
//  Created by Tariq Maged on 07/01/2022.
//

import UIKit

class AnimatorFactory{
    
    //singleton
    static let instance = AnimatorFactory()
    let animationDuration = 0.2
    
    func playAnimation(_ view:UIView){
        UIView.animate(withDuration: animationDuration,animations: {
            view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        },
        completion: { _ in
            self.enlargeViewAnimation(view)
        })
    }
    
     func enlargeViewAnimation(_ view:UIView){
        guard let centerView = view.superview?.center else {return}
        UIView.animate(withDuration: animationDuration,animations: {
            view.center = centerView
            view.transform = CGAffineTransform(scaleX: 1.5, y: 2)
        }, completion: nil)
    }
    
     func animateToNormalSize(_ view:UIView){
        UIView.animate(withDuration: animationDuration) {
            view.transform = CGAffineTransform.identity
        }
    }
    
    func fadeOutView(_ view:UIView){
        UIView.animate(
            withDuration: 0.7, delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0,
            options: .curveLinear,
            animations: {
                
                view.alpha = 0
                
                
            }) { completed in
            if completed {
                view.removeFromSuperview()
            }
        }
        
    }
}
