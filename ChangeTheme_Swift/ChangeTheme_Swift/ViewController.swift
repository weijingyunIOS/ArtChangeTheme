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
            self!.testImage.image = UIImage.artModule1Image(imageString: "Module1_test")
            let testViewStyle = ArtUIStyle.artModule1Style(styleKey: "TestView")
            self!.testView.backgroundColor = testViewStyle.color()
            self!.testWidth.constant = testViewStyle.width
            self!.testWidth.constant = testViewStyle.height
        };
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        print((#file as NSString).lastPathComponent + "正常释放")
    }

    @IBAction func downPath(_ sender: Any) {
        
        do {
            let documentDirectory = try NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first.unwrap()
            let toPath = documentDirectory + "/stylePath"
          
            do {
                try FileManager.default.removeItem(atPath: toPath)
            } catch {
                
            }
            let path = try Bundle.main.path(forResource: "styleBundle1", ofType: "bundle").unwrap()
            do {
                try FileManager.default.copyItem(atPath: path, toPath: toPath)
                ArtUIStyleManager.share .reloadNewStyle(path: toPath)
            } catch {
                
            }
        } catch {
            
        }
        
    }

    @IBAction func downBundle(_ sender: Any) {
        
        do {
            let documentDirectory = try NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first.unwrap()
            let toPath = documentDirectory + "/stylePath.bundle"
            
            do {
                try FileManager.default.removeItem(atPath: toPath)
            } catch {
                
            }
            let path = try Bundle.main.path(forResource: "styleBundle1", ofType: "bundle").unwrap()
            do {
                try FileManager.default.copyItem(atPath: path, toPath: toPath)
                ArtUIStyleManager.share .reloadNewStyle(path: toPath)
            } catch {
                
            }
        } catch {
            
        }
    }
    
    
    @IBAction func mainDefault(_ sender: Any) {
        ArtUIStyleManager.share.reloadNewStyle(bundle: nil)
    }
    
    @IBAction func bundle(_ sender: Any) {
        ArtUIStyleManager.share.reloadNewStyle(bundleName: "styleBundle1")
    }
}

