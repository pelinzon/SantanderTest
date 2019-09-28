//
//  FormPresenter.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FormPresentationLogic {
//  func presentSomething(response: Form.Something.Response)
}

class FormPresenter: FormPresentationLogic {
  weak var viewController: FormDisplayLogic?
}
