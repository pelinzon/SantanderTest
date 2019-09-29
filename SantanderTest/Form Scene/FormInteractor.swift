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
    func allFieldsAreValid(name: String, email: String, tel: String) -> Bool
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

    func allFieldsAreValid(name: String, email: String, tel: String) -> Bool {
        if name == "" { return false }

        if !emailIsValid(email) { return false }

        if tel.count != 9  { return false }

        return true
    }

    func emailIsValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }

//    func telIsValid(_ tel: String) -> String {
//        let telNumber = tel.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//        let mask = "(XX) XXXXX-XXXX"
//
//        var formattedTelNumber = ""
//        var index = telNumber.startIndex
//        for char in mask where index < telNumber.endIndex {
//            if char == "X" {
//                formattedTelNumber.append(telNumber[index])
//                index = telNumber.index(after: index)
//            } else {
//                formattedTelNumber.append(char)
//            }
//        }
//        return formattedTelNumber
//    }

}
