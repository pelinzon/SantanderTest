//
//  FormViewController.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FormDisplayLogic: class {
}

class FormViewController: UIViewController, FormDisplayLogic {
  var interactor: FormBusinessLogic?

  // MARK: Object lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup()
  {
    let viewController = self
    let interactor = FormInteractor()
    let presenter = FormPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
  }

  // MARK: View lifecycle

  override func viewDidLoad()
  {
    super.viewDidLoad()
  }

    @IBOutlet var thankYouView: UIView!

    @IBAction func checkboxPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

    @IBAction func sendButtonPressed() {
        // verify fields & clear upon submission
        view.addSubview(thankYouView)
    }

    @IBAction func newMessageButtonPressed() {
        thankYouView.removeFromSuperview()
    }
}
