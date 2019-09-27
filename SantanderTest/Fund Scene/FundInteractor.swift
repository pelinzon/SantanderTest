//
//  FundInteractor.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FundBusinessLogic
{
  func doSomething(request: Fund.Something.Request)
}

protocol FundDataStore
{
  //var name: String { get set }
}

class FundInteractor: FundBusinessLogic, FundDataStore
{
  var presenter: FundPresentationLogic?
  var worker: FundWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Fund.Something.Request)
  {
    worker = FundWorker()
    worker?.doSomeWork()
    
    let response = Fund.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
