//
//  FormInteractor.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FormBusinessLogic
{
  func doSomething(request: Form.Something.Request)
}

protocol FormDataStore
{
  //var name: String { get set }
}

class FormInteractor: FormBusinessLogic, FormDataStore
{
  var presenter: FormPresentationLogic?
  var worker: FormWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Form.Something.Request)
  {
    worker = FormWorker()
    worker?.doSomeWork()
    
    let response = Form.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
