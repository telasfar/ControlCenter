//
//  ButtonsFactory.swift
//  BodyBuildTask
//
//  Created by Tariq Maged on 07/01/2022.
//

import UIKit
class ButtonsFactory{
    
    //vars
    let imgArr = [#imageLiteral(resourceName: "custom"),#imageLiteral(resourceName: "audio"),#imageLiteral(resourceName: "brightness"),#imageLiteral(resourceName: "contrast"),#imageLiteral(resourceName: "gradient"),#imageLiteral(resourceName: "SideMenuIcon")]
    var controlView:ControlCenterView?

     func createRoundedBtns(img:UIImage,selector:Selector =  #selector(toggleBackGround(_:)) )->RoundedBlurButton{
        let btnRounded = RoundedBlurButton()
        btnRounded.clipsToBounds = true
        btnRounded.tintColor = .white
        btnRounded.setImage(img, for: .normal)
        btnRounded.addTarget(self, action:selector , for: .touchUpInside)
        btnRounded.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:))))
        return btnRounded
    }
    
    func fillBtnArr(state:CurrentViewState,widgetCount:Int)->[RoundedBlurButton]{
        var btnArr = [RoundedBlurButton]()
        var range:Range<Int>
        switch state{
        case .normal:
            range = 0..<widgetCount
        case .detailed:
            range = 0..<imgArr.count
        }
        for i in range{
            let btn = createRoundedBtns(img: imgArr[i])
            btnArr.append(btn)
        }
        return btnArr
    }
    
    @objc func toggleBackGround(_ btn:RoundedBlurButton){
        let color = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)].randomElement()
        btn.backgroundColor = btn.isButtonActive ? color:.clear
        btn.isButtonActive = !btn.isButtonActive
    }
    
    @objc func handleLongGesture(_ gesture:UILongPressGestureRecognizer){
        guard (gesture.state == UIGestureRecognizer.State.began),let controlView = controlView ,controlView.widgetView.currentState == .detailed else {return}
        let bluetoothView = BlueToothView()

        UIView.transition(with: controlView.widgetView, duration: 4.4, options: .curveEaseInOut, animations: {
            controlView.widgetView.addSubview(bluetoothView)
            bluetoothView.fillSuperview()
        }, completion: nil)
        
    }
}
