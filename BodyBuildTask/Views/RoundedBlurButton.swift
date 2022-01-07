//
//  RoundedBlurButton.swift
//  BodyBuildTask
//
//  Created by Tariq Maged on 07/01/2022.
//

import UIKit

class RoundedBlurButton: UIButton {

//vars
   var isButtonActive = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func addBlurEffect(){
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        blur.layer.cornerRadius = bounds.size.height/2
        blur.clipsToBounds = true
        self.insertSubview(blur, at: 0)
        if let imageView = self.imageView{
            self.bringSubviewToFront(imageView)
        }
    }
    
     func initViews(){
        clipsToBounds = true
        addBlurEffect()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

}
