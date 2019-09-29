//
//  FundModel.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 26/09/19.
//  Copyright © 2019 Lucas Pelinzon. All rights reserved.
//

import Foundation

struct FundModel: Decodable {
    let screen: Screen
}

struct Screen: Decodable {
    let title: String
    let fundName: String
    let whatIs: String
    let definition: String
    let riskTitle: String
    let risk: Int
    let infoTitle: String
    let moreInfo: MoreInfo
    let info: [Info]
    let downInfo: [Info]
}

struct MoreInfo: Decodable {
    let month: Earnings
    let year: Earnings
    let last12Months : Earnings

    private enum CodingKeys : String, CodingKey {
        case month, year, last12Months = "12months"
    }
}

struct Earnings: Decodable {
    let fund: Double
    let CDI: Double
}

struct Info: Decodable {
    let name: String
    let data: String?
}
