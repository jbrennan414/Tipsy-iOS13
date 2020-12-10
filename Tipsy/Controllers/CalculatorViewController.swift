//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipValue: Float = 0.1
    var splitValue: Double = 2
    var costPerUser: String = ""
    
    @IBAction func tipChanged(_ sender: UIButton) {
        let percentageValue = sender.titleLabel?.text ?? "none"

        switch percentageValue {
            case "0%":
                zeroPctButton.isSelected = true
                tenPctButton.isSelected = false
                twentyPctButton.isSelected = false
                tipValue = 0.0
            case "10%":
                zeroPctButton.isSelected = false
                tenPctButton.isSelected = true
                twentyPctButton.isSelected = false
                tipValue = 0.1
        case "20%":
                zeroPctButton.isSelected = false
                tenPctButton.isSelected = false
                twentyPctButton.isSelected = true
                tipValue = 0.2
            default:
                zeroPctButton.isSelected = false
                tenPctButton.isSelected = false
                twentyPctButton.isSelected = false
        }
        
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        splitValue = sender.value
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billText = billTextField.text ?? ""
        let subtotal = Float(billText) ?? 0.00
        
        let tip = tipValue + 1
        
        let total = subtotal * tip
        let costPerPerson = String(format: "%.2f", total/Float(splitValue))
        
        self.costPerUser = costPerPerson
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            let rawTipValue = String(format: "%.0f", Float(self.tipValue) * 100)
            let numOfPeople = String(format: "%.0f", self.splitValue)
            
            let description = "Split between \(numOfPeople) people, with \(rawTipValue)% tip"
            
            destinationVC.totalValue = self.costPerUser
            destinationVC.settingsValue = description
            
        }
        
    }
    



}

