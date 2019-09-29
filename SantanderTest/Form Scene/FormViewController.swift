//
//  FormViewController.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FormDisplayLogic: class {
    func updateView(with model: FormModel)
    func clearTextFields()
}

class FormViewController: UIViewController, FormDisplayLogic {

    @IBOutlet weak var nameFieldTitle: UILabel!
    @IBOutlet weak var emailFieldTitle: UILabel!
    @IBOutlet weak var telephoneFieldTitle: UILabel!
    @IBOutlet weak var newsletterButton: UIButton!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!

    @IBOutlet weak var nameDivider: UIView!
    @IBOutlet weak var emailDivider: UIView!
    @IBOutlet weak var telephoneDivider: UIView!

    @IBOutlet var thankYouView: UIView!
    @IBOutlet weak var sendButton: UIButton!

    @IBAction func checkboxPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

    @IBAction func sendMessageButtonPressed(_ sender: UIButton) {

        var allAreValid = true

        if nameTextField.text != "" {
            nameDivider.backgroundColor = #colorLiteral(red: 0.3960784314, green: 0.7450980392, blue: 0.1882352941, alpha: 1)
        } else {
            nameDivider.backgroundColor = #colorLiteral(red: 1, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
            allAreValid = false
        }

        if interactor.emailIsValid(emailTextField.text ?? "") {
            emailDivider.backgroundColor = #colorLiteral(red: 0.3960784314, green: 0.7450980392, blue: 0.1882352941, alpha: 1)
        } else {
            emailDivider.backgroundColor = #colorLiteral(red: 1, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
            allAreValid = false
        }

        if telephoneTextField.text?.count == 9 {
            telephoneDivider.backgroundColor = #colorLiteral(red: 0.3960784314, green: 0.7450980392, blue: 0.1882352941, alpha: 1)
        } else {
            telephoneDivider.backgroundColor = #colorLiteral(red: 1, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
            allAreValid = false
        }

        if allAreValid {
            UIView.animate(withDuration: 0.25, animations: {
                sender.alpha = 0.6
                sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
                UIView.animate(withDuration: 0.25, animations: {
                    sender.alpha = 1
                    sender.transform = .identity
                }, completion: { _ in
                    self.showThankYouView()
                    self.presenter.clearTextFields()
                })
            })
        } else {
            let alert = UIAlertController(title: "Campos inválidos", message: "Por favor verifique as informações e tente novamente", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    @IBAction func newMessageButtonPressed() {
        thankYouView.removeFromSuperview()
    }

    let interactor = FormInteractor()
    let presenter = FormPresenter()


    // MARK: View Lifecycle
    override func viewDidLoad() {
         super.viewDidLoad()
         presenter.viewController = self
         interactor.presenter = presenter
         sendButton.layer.cornerRadius = 25

        telephoneTextField.delegate = self

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        interactor.updateFields()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func updateView(with model: FormModel) {
        self.nameFieldTitle.text = model.cells[1].message
        self.emailFieldTitle.text = model.cells[2].message
        self.telephoneFieldTitle.text = model.cells[3].message
        self.newsletterButton.setTitle("  \(model.cells[4].message)", for: .normal)
        self.sendButton.setTitle(model.cells[5].message, for: .normal)
    }

    func clearTextFields() {
        nameTextField.text = ""
        emailTextField.text = ""
        telephoneTextField.text = ""
        newsletterButton.isSelected = false

        nameDivider.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        emailDivider.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        telephoneDivider.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
    }

    func showThankYouView() {
        thankYouView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thankYouView)
        NSLayoutConstraint.activate([
            thankYouView.widthAnchor.constraint(equalToConstant: view.frame.width),
            thankYouView.heightAnchor.constraint(equalToConstant: view.frame.height),
            thankYouView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thankYouView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension FormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formattedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if formattedString.count > 9 {
            return false
        } else {
            return true
        }
    }
}

