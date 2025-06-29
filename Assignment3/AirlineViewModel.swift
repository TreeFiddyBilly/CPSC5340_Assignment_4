//
//  AirlineViewModel.swift
//  Assignment3
//
//  Created by user272344 on 5/31/25.
//

import Foundation

class AirlineViewModel : ObservableObject {
    @Published private(set) var AirlineData = [AirlineModel]()
    private let url = "https://api.aviationstack.com/v1/airlines?limit=200&access_key=d8f2ed2acf559aa905bc03bbf60ad229"
    
    
    func fetchData() {
        if let url = URL(string: url) {
            URLSession
                .shared
                .dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if let data = data {
                            do {
                                let results = try JSONDecoder().decode(AirlineResults.self, from: data)
                                DispatchQueue.main.async {
                                    self.AirlineData = results.data
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }.resume()
        }
    }
    
}
