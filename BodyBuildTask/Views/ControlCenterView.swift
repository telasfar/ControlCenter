//
//  ControlCenterView.swift
//  BodyBuildTask
//
//  Created by Tariq Maged on 07/01/2022.
//

import UIKit

class ControlCenterView: UIView {

    //vars
    var widgetView = WidgetView()
    let btnFactory = ButtonsFactory()
    var mainButtonArr = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fillButtonArrs()
        setupWidget()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWidget(){
        addSubview(widgetView)
        widgetView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 80, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 180, heightConstant: 180)
    }
    
    func fillButtonArrs(){
        mainButtonArr.removeAll()
        btnFactory.controlView = self
        mainButtonArr = btnFactory.fillBtnArr(state: widgetView.currentState, widgetCount: widgetView.widgetCount)
        fillMainStackView()
    }
    
    func fillMainStackView(){
        let devidedArr = mainButtonArr.splitBy(2)
        devidedArr.forEach{
            widgetView.appendToMainStack($0)
        }
    }

    @objc func toggleBackGround(_ btn:RoundedBlurButton){
        let color = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)].randomElement()
        btn.backgroundColor = btn.isButtonActive ? color:.clear
        btn.isButtonActive = !btn.isButtonActive
    }

}
