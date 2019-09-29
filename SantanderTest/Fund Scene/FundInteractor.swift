//
//  FundInteractor.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

protocol FundBusinessLogic {
    func refreshData()
}

class FundInteractor: FundBusinessLogic {

    var presenter: FundPresentationLogic?
    var worker = FundWorker()

    func refreshData() {
        let url = "https://floating-mountain-50292.herokuapp.com/fund.json"
        worker.queryInfo(from: url, completion: { decodedData in
            self.presenter!.updateView(with: decodedData)
        })
    }
}
