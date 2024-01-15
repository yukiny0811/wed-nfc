//
//  ReadViewController.swift
//  wed-nfc
//
//  Created by Kyoya Yamaguchi on 2024/01/15.
//

import UIKit

class ReadViewController: UIViewController {
    
    @IBOutlet var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapRead() {
        NFCManager.shared.read { text in
            if let text = text {
                self.textLabel.text = text
            } else {
                self.textLabel.text = "データなし"
            }
        }
        
        
        //複雑なデータを扱いたい場合
        //        CodableNFCManager.shared.read { tagData in
        //            if let tagData = tagData {
        //                self.textLabel.text = "\(tagData.text), \(tagData.number)"
        //            } else {
        //                self.textLabel.text = "データなし"
        //            }
        //        }
        
    }
    
}
