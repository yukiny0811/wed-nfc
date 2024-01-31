//
//  WriteViewController.swift
//  wed-nfc
//
//  Created by Kyoya Yamaguchi on 2024/01/15.
//

import UIKit

class WriteViewController: UIViewController {
    
    @IBOutlet var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func didTapWrite() {
        NFCManager.shared.write(text: inputTextField.text!)
        
        
        //複雑なデータを扱いたい場合
        //        CodableNFCManager.shared.write(tagData: TagData(text: inputTextField.text!, number: 0))
    }
}
