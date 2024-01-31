//
//  HomeViewController.swift
//  wed-nfc
//
//  Created by Kodama Kai on 2024/01/31.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var StepLabel : UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            let date = Date()
            let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: date)!
            let count = try! await StepManager.getStepCount(startDate: oneDayBefore, endDate: date)
            StepLabel.text = String(count) + "steps"
        }
        
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
