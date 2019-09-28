//
//  FundViewController.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FundDisplayLogic: class
{
  func displaySomething(viewModel: Fund.Something.ViewModel)
}

class FundViewController: UIViewController, FundDisplayLogic
{
  var interactor: FundBusinessLogic?
  var router: (NSObjectProtocol & FundRoutingLogic & FundDataPassing)?

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
    let interactor = FundInteractor()
    let presenter = FundPresenter()
    let router = FundRouter()
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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!

  func doSomething()
  {
    let request = Fund.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: Fund.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}

extension FundViewController: UIScrollViewDelegate {

}
