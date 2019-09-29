//
//  FormInteractor.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FormBusinessLogic {
    func updateFields()
}

class FormInteractor: FormBusinessLogic {
    var presenter: FormPresentationLogic?
    var worker = FormWorker()

    func updateFields() {
        let url = "https://floating-mountain-50292.herokuapp.com/cells.json"
        worker.getCells(from: url, completion: { decodedData in
            self.presenter!.updateView(with: decodedData)
        })
    }
}
