//
//  FormPresenter.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FormPresentationLogic {
    func updateView(with data: FormModel)
}

class FormPresenter: FormPresentationLogic {

  weak var viewController: FormDisplayLogic?

    func updateView(with data: FormModel) {
        DispatchQueue.main.async {
            self.viewController?.updateView(with: data)
        }
    }
}
