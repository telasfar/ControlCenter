//
//  BlueToothView.swift
//  BodyBuildTask
//
//  Created by Tariq Maged on 07/01/2022.
//

import UIKit

class BlueToothView: UIView {
    
    //vars
    let lblTitle:UILabel = {
        let lblValue = UILabel()
        lblValue.textAlignment = .center
        lblValue.textColor = .lightGray
        lblValue.text = "Bluetooth"
        lblValue.font = UIFont.systemFont(ofSize: 18)
        return lblValue
    }()
    let seperatedView:UIView = {
        let sepView = UIView()
        sepView.backgroundColor = .lightGray
        return sepView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func initViews() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tag = 12345
        clipsToBounds = true
        addSubview(lblTitle)
        lblTitle.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 2, bottomConstant: 2, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        addSubview(seperatedView)
        seperatedView.anchor(lblTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 2, leftConstant: 2, bottomConstant: 2, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 8
    }

}
