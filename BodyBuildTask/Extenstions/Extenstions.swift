//
//  Extenstion UiView.swift
//  BodyBuildTask
//
//  Created by Tariq Maged on 07/01/2022.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          layer.mask = mask
      }
    
    @discardableResult
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true}) //gamed ya ebny
        
        return anchors
    }
    
    public func fillSuperview(constant:CGFloat = 2) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor,constant: constant).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor,constant: -1*constant).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor,constant: constant).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant: -1*constant).isActive = true
        }
    }
    
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }

    
    func addDarkTint(target: Any?, action: Selector) {
        guard self.viewWithTag(1001001) == nil else {
            return
        }
        let tintTag = 1001001
        let tintView = UIButton(frame: frame)
        tintView.backgroundColor = .lightGray
        tintView.translatesAutoresizingMaskIntoConstraints = false
        tintView.alpha = 0
        tintView.tag = tintTag
        
        addSubview(tintView)
        NSLayoutConstraint.activate([
            tintView.topAnchor.constraint(equalTo: topAnchor),
            tintView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tintView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tintView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        UIView.animate(withDuration: 0.2) {
            tintView.alpha = 0.6
        }
        
        tintView.addTarget(target, action: action, for: .touchUpInside)
    }
    
    @objc func removeDarkTint() {
        let tintTag = 1001001
        guard let tintView = viewWithTag(tintTag) else { return }
        UIView.animate(withDuration: 0.2, animations: {
            tintView.alpha = 0
        }) { _ in
            tintView.removeFromSuperview()
        }
    }
    
}

extension UIViewController {
    func addFadeBackground(_ status:Bool,color:UIColor?){
        var fadeView:UIView
        if status{
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView.backgroundColor = color
            fadeView.alpha = 0.0
            fadeView.tag = 98
            view.addSubview(fadeView)
            fadeView.fadeTo(alphaValue: 0.7, withDuration: 0.3)
            
        }else {
            for subview in view.subviews {
                if subview.tag == 98 {
                    UIView.animate(withDuration: 0.3, animations: {
                        subview.alpha = 0.0
                    }) { (finish) in
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
}

extension Array {

    func splitBy(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }

}
