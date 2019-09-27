//
//  FundPresenter.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FundPresentationLogic
{
  func presentSomething(response: Fund.Something.Response)
}

class FundPresenter: FundPresentationLogic
{
  weak var viewController: FundDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Fund.Something.Response)
  {
    let viewModel = Fund.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
