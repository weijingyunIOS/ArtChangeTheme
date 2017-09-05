//
//  ViewController.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/8/28.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let view1 = UIView()
        let view2 = UIView()
        
        ArtUIStyleManager.share.saveStyle(strongSelf: self) {[weak view1,weak view2,weak self] in
            view1?.backgroundColor = UIColor.yellow
            view2?.backgroundColor = UIColor.blue
            self?.view.backgroundColor = UIColor.red
        };
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

