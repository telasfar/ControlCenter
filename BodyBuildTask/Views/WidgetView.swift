//
//  WidgetView.swift
//  BodyBuildTask
//
//  Created by Tariq Maged on 07/01/2022.
//

import UIKit

class WidgetView: UIView {

    //vars
    var currentState:CurrentViewState = .normal{
        didSet{
            emptyMainstack()
            if let superView = superview as? ControlCenterView{
                superView.fillButtonArrs()
            }
        }
    }
    var widgetCount = 4
    let mainStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    func createMiniStackView(btnArr:[UIButton])->UIStackView{
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        btnArr.forEach{
         stackView.addArrangedSubview($0)
            adjustAspectRatio($0)
        }
        return stackView
    }
    
    func adjustAspectRatio(_ view:UIView){
        guard let adjustHeight = view.superview?.heightAnchor else {return}
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalTo: adjustHeight, multiplier: 1),
         view.widthAnchor.constraint(equalTo: adjustHeight, multiplier: 1)
        ])
    }
    
    func appendToMainStack(_ arr:[UIButton]){
        let stack = createMiniStackView(btnArr: arr)
        mainStackView.addArrangedSubview(stack)
    }
    
    func emptyMainstack(){
        for stackSubView in mainStackView.arrangedSubviews{
            stackSubView.removeFromSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        addGetsures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 8
    }
    
     func initViews() {
        backgroundColor = #colorLiteral(red: 0.0997913245, green: 0.0997913245, blue: 0.0997913245, alpha: 0.7087838887)
        clipsToBounds = true
        addSubview(mainStackView)
        mainStackView.fillSuperview()
    }
    
    func addGetsures(){
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        longGesture.minimumPressDuration = 0.5
        addGestureRecognizer(longGesture)

    }
    
    @objc func handleLongGesture(_ gesture:UILongPressGestureRecognizer){
        if (gesture.state != UIGestureRecognizer.State.began) || (currentState == .detailed) {return}
        superview?.addDarkTint(target: self, action: #selector(handleDarkTint))
        superview?.bringSubviewToFront(self)
        AnimatorFactory.instance.playAnimation(self)
        currentState = .detailed
    }
    
    @objc func handleDarkTint(){
        superview?.removeDarkTint()
        currentState = .normal
        AnimatorFactory.instance.animateToNormalSize(self)
        for subBluetoothView in subviews{
            if subBluetoothView.tag == 12345{
                AnimatorFactory.instance.fadeOutView(subBluetoothView)
            }
        }
    }

}
