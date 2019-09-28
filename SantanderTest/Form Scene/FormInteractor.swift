//
//  FormInteractor.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FormBusinessLogic {
}

class FormInteractor: FormBusinessLogic {
    var presenter: FormPresentationLogic?
    var worker: FormWorker?
}
