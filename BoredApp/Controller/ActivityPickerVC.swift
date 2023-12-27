//
//  ActivityPickerVC.swift
//  BoredApp
//
//  Created by Виктория Григорьева on 30.11.2023.
//

import UIKit

class ActivityPickerVC: UIViewController, ActivityManagerDelegate {
    
    var participants: Int = 0
    var category: String? = ""
    var maxPrice: Float = 0
    
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var activityLabel: UILabel!
    
    @IBAction func findActivity(_ sender: UIButton) {
        
        findActivity()
    }
    
    @IBAction func findRandomActivity(_ sender: UIButton) {
        findRandomActivity()
    }
    
    var activityManager = ActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityManager.delegate = self
        
        findActivity()
    }
    

    func didUpdateActivity(_ activityManager: ActivityManager, activity: ActivityModel) {
            DispatchQueue.main.async {
                self.activityLabel.text = activity.activity
                self.categoryImage.image = UIImage(named: activity.type)
            }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
   
    func findActivity() {
        activityManager.fetchActivity(price: maxPrice, category: category ?? "")
    }
    
    func findRandomActivity() {
        activityManager.fetchActivity()
    }
}


