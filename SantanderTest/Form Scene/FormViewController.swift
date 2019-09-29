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
}

class FormViewController: UIViewController, FormDisplayLogic {

    @IBOutlet weak var nameFieldTitle: UILabel!
    @IBOutlet weak var emailFieldTitle: UILabel!
    @IBOutlet weak var telephoneFieldTitle: UILabel!
    @IBOutlet weak var newsletterButton: UIButton!


    @IBOutlet var thankYouView: UIView!
    @IBOutlet weak var sendButton: UIButton!

    @IBAction func checkboxPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

    @IBAction func sendMessageButtonPressed(_ sender: UIButton) {
        // verify fields & clear upon submission

        UIView.animate(withDuration: 0.25, animations: {
            sender.alpha = 0.6
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, animations: {
                sender.alpha = 1
                sender.transform = .identity
            }, completion: { _ in
                self.showThankYouView()
            })
        })
    }

    @IBAction func newMessageButtonPressed() {
        thankYouView.removeFromSuperview()
    }

    let interactor = FormInteractor()
    let presenter = FormPresenter()

    override func viewDidLoad() {
         super.viewDidLoad()
         presenter.viewController = self
         interactor.presenter = presenter
         sendButton.layer.cornerRadius = 25
    }

    override func viewWillAppear(_ animated: Bool) {
        interactor.updateFields()
    }

    func updateView(with model: FormModel) {
        self.nameFieldTitle.text = model.cells[1].message
        self.emailFieldTitle.text = model.cells[2].message
        self.telephoneFieldTitle.text = model.cells[3].message
        self.newsletterButton.setTitle("  \(model.cells[4].message)", for: .normal)
        self.sendButton.setTitle(model.cells[5].message, for: .normal)
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
