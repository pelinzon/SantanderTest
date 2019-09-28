//
//  FormViewController.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FormDisplayLogic: class
{
  func displaySomething(viewModel: Form.Something.ViewModel)
}

class FormViewController: UIViewController, FormDisplayLogic
{
  var interactor: FormBusinessLogic?
  var router: (NSObjectProtocol & FormRoutingLogic & FormDataPassing)?

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
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = FormInteractor()
    let presenter = FormPresenter()
    let router = FormRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
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

    func doSomething()
  {
    let request = Form.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: Form.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
