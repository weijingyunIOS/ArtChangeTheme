//
//  ViewController.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/8/28.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var testWidth: NSLayoutConstraint!
    @IBOutlet weak var testHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.testLabel.text = "我是一个测试文本"
        ArtUIStyleManager.share.saveStyle(strongSelf: self) {[weak self] in
            guard self != nil else {
                return
            }
            let testStyle = ArtUIStyle.artModule1Style(styleKey: "Test")
            self!.testLabel.textColor = testStyle.color()
            self!.testLabel.font = testStyle.font()
            self!.view.backgroundColor = UIColor.artAppStyle(styleKey: "vcBackground")
        };
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func downPath(_ sender: Any) {
        
    }

    @IBAction func downBundle(_ sender: Any) {
        
    }
    
    
    @IBAction func mainDefault(_ sender: Any) {
        ArtUIStyleManager.share.reloadNewStyle(bundle: nil)
    }
    
    @IBAction func bundle(_ sender: Any) {
        ArtUIStyleManager.share.reloadNewStyle(bundleName: "styleBundle1")
    }
}

