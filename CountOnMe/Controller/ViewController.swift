//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    
    let calculate = Calculate()
    
    // MARK: - Actions
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculate.addNewNumber(numberText: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculate.addOperator(operators: .plus)
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculate.addOperator(operators: .times)
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculate.addOperator(operators: .minus)
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculate.addOperator(operators: .obelus)
    }
    
    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculate.resetCalcul()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculate.equal()
        
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name(rawValue: "calculText")
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCalculText(notification:)), name: name, object: nil)
        let nameAlert = Notification.Name(rawValue: "displayAlert")
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAlert(notification:)), name: nameAlert, object: nil)
    }
    
    @objc func refreshCalculText(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let calculText = userInfo["calculText"] as? String else { return }
        textView.text = calculText
    }
    
    @objc func notificationAlert(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let message = userInfo["message"] as? String else { return }
        displayAlert(message: message)
        
    }
    
}

// MARK: - displayAlert

extension ViewController {
    
    func displayAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}



