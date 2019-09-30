//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var textView: UITextView!
    
    /// Stock the instance of the class Calculate
    private let calculate = Calculate()
    
    // MARK: - Actions
    
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculate.addNewNumber(numberText: numberText)
    }
    
    /// Method that manages operators's buttons
    @IBAction private func tappedOperatorButton(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else {return}
        switch title {
        case "+":
            calculate.addOperator(operators: .plus)
        case "-":
            calculate.addOperator(operators: .minus)
        case "/":
            calculate.addOperator(operators: .obelus)
        case "x":
            calculate.addOperator(operators: .times)
        default:
            break
        }
    }
    
    @IBAction private func tappedResetButton(_ sender: UIButton) {
        calculate.resetCalcul()
    }
    
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
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
    
    // Deinitializer to delete the notifications in memory in the controller
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    
    @objc
    private func refreshCalculText(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let calculText = userInfo["calculText"] as? String else { return }
        textView.text = calculText
    }
    
    @objc
    private func notificationAlert(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let message = userInfo["message"] as? String else { return }
        displayAlert(message: message)
    }
    
    /// Method that manage alerts which will be used in my model
    func displayAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
