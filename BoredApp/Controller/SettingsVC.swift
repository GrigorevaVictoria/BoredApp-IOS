//
//  SettingsVC.swift
//  BoredApp
//
//  Created by Виктория Григорьева on 04.12.2023.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var price: UISwitch!
    @IBOutlet var categoryTextLabel: UILabel!
    @IBOutlet var buttonTopConstraint: NSLayoutConstraint!
    @IBOutlet var categorySwitchView: UIView!
    @IBOutlet var stopBoredomButton: UIButton!
    @IBOutlet var categoryView: UIView!
    
    var buttonConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    @IBAction func categorySwitch(_ sender: UISwitch) {
        buttonTopConstraint.isActive = false
        stopBoredomButton.translatesAutoresizingMaskIntoConstraints = false
 
        buttonConstraint.isActive = false
        
        if sender.isOn == false {
            
            categoryPicker.isHidden = true
            categoryView.isHidden = true
            buttonConstraint = stopBoredomButton.topAnchor.constraint(equalTo: categorySwitchView.bottomAnchor, constant: 25)
            
            buttonConstraint.isActive = true
            
        } else {
            categoryView.isHidden = false
            categoryPicker.isHidden = false
            categoryTextLabel.text = "Choose a category from list:"
            buttonConstraint.isActive = false
            
            buttonConstraint = stopBoredomButton.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 25)
            buttonConstraint.isActive = true
        }
    }
    
    let categories = ["education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPicker.dataSource = self
        categoryPicker.delegate  = self
        
        for constraint in self.view.constraints {
            if constraint.identifier == "myConstraint" {
               constraint.constant = 50
            }
        }
        
        buttonConstraint = stopBoredomButton.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 25)
    }
    
    @IBAction func findActivity(_ sender: UIButton) {
        performSegue(withIdentifier: "ToActivityPickerVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToActivityPickerVC" {
           
            let controller = segue.destination as! ActivityPickerVC
            
            if categoryPicker.isHidden  {
                controller.category = nil
            } else {
                controller.category = categories[categoryPicker.selectedRow(inComponent: 0)]
            }
            if price.isOn {
                controller.maxPrice = 0
            } else {
                controller.maxPrice = 1
            }
        }
    }
    
}

extension SettingsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 70
    }
    
}

extension SettingsVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        "no categories"
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        createSubView(row: row, width: pickerView.bounds.width)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    
}

extension SettingsVC {
    func createSubView(row: Int, width: CGFloat) -> UIView {
        
        let myView = UIView(frame: CGRectMake(0, 0, width - 30, 20))
        let myImageView = UIImageView(frame: CGRectMake(0, 0, 20, 20))
        let myLabel = UILabel(frame: CGRectMake(30, 0, width - 30, 20))
        
        myImageView.image = UIImage(named: categories[row])
        myLabel.text = categories[row]
        
        myView.addSubview(myImageView)
        myView.addSubview(myLabel)
        
        
        return myView
    }
}
