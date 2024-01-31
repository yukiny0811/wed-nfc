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
        Task {
            let date = Date()
            let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: date)!
            let count = try! await StepManager.getStepCount(startDate: oneDayBefore, endDate: date)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func didTapWrite() {
//        NFCManager.shared.write(text: inputTextField.text!)
        NFCManager.shared.read { text in
            if let text = text {
                let nfccount = Int(text) ?? 0
                Task {
                    let date = Date()
                    let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: date)!
                    let count = try! await StepManager.getStepCount(startDate: oneDayBefore, endDate: date)
                    
                    if count > nfccount {
                        print ("count is bigger")
                    }
                }
            }
        }
        

        //複雑なデータを扱いたい場合
        //        CodableNFCManager.shared.write(tagData: TagData(text: inputTextField.text!, number: 0))
    }
}
