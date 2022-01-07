//
//  ViewController.swift
//  BodyBuildTask
//
//  Created by Tariq Maged on 07/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
   //vars
    var controlCenterView = ControlCenterView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(controlCenterView)
        controlCenterView.fillSuperview()
    }
    
    

}

