//
//  WriteViewController.swift
//  wed-nfc
//
//  Created by Kyoya Yamaguchi on 2024/01/15.
//

import UIKit
import Drops

class WriteViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
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
        Task {
            let nfcText: String? = await withCheckedContinuation { continuation in
                NFCManager.shared.read { text in
                    continuation.resume(returning: text)
                }
            }
            guard let nfcText, let nfcCount = Int(nfcText) else {
                label.text = "記録なし"
                NFCManager.shared.write(text: "error")
                return
            }
            label.text = nfcText + "kcal"
            NFCManager.shared.write(text: nfcText)
            try? await Task.sleep(for: .seconds(4))
            
            // get step count
            let date = Date()
            let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: date)!
            let stepCount = try! await StepManager.getStepCount(startDate: oneDayBefore, endDate: date)
            
            guard stepCount > nfcCount else {
                Drops.show("歩数が足りないです！")
                return
            }
            Drops.show("たくさん歩きましたね！")
            NFCManager.shared.write(text: "煮玉子もらえる")
            label.text = "煮玉子！"
            
        }
    }
}
