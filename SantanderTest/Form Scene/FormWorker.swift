//
//  FormWorker.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

class FormWorker {
    func getCells(from url: String, completion: @escaping (_ decodedData: FormModel) -> Void) {

        guard let url = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(FormModel.self, from: data)
                completion(decodedData)
            } catch {
                print(error)
            }
        }.resume()
    }
}
