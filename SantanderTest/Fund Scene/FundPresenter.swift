//
//  FundPresenter.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FundPresentationLogic {
    func updateView(with data: FundModel)
}

class FundPresenter: FundPresentationLogic {

    var viewController: FundDisplayLogic?

    func updateView(with data: FundModel) {
        DispatchQueue.main.async {
            self.viewController?.updateView(with: data)
        }
    }
}
