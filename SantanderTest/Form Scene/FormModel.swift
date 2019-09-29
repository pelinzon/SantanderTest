//
//  FormModel.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 26/09/19.
//  Copyright © 2019 Lucas Pelinzon. All rights reserved.
//

import Foundation

struct FormModel: Decodable {
    let cells: [Cell]
}

struct Cell: Decodable {
    let message: String
}
