//
//  FundWorker.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

class FundWorker {
    func queryInfo(from url: String, completion: @escaping (_ decodedData: FundModel) -> Void) {
        print("Reached Worker")

        guard let url = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(FundModel.self, from: data)
                completion(decodedData)
            } catch {
                print(error)
            }
        }.resume()
    }
}
