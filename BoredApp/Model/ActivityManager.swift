//
//  ActivityManager.swift
//  BoredApp
//
//  Created by Виктория Григорьева on 30.11.2023.
//

import Foundation

protocol ActivityManagerDelegate {
    func didUpdateActivity(_ activityManager: ActivityManager, activity: ActivityModel)
    func didFailWithError(error: Error)
}


struct ActivityManager {
    let activityURL = "https://www.boredapi.com/api/activity"
    
    var delegate: ActivityManagerDelegate?

    func fetchActivity (price: Float, category: String) {
        
            let urlString = "\(activityURL)?&maxprice=\(price)&type=\(category)"
        
            performRequest(with: urlString)
        }
    
    func fetchActivity () {
        
            let urlString = "\(activityURL)"
        
            performRequest(with: urlString)
        }
    
    func performRequest(with urlString: String) {

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if let activity = self.parseJSON(safeData) {
                        self.delegate?.didUpdateActivity(self, activity: activity)
                    }
                }
            }

            task.resume()
        }
    }
    
    func parseJSON(_ activityData: Data) -> ActivityModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActivityData.self, from: activityData)
            let activeDescription = decodedData.activity
            let key = decodedData.key
            let participants = decodedData.participants
            let type = decodedData.type
            let price = decodedData.price
            
            let activity = ActivityModel(activity: activeDescription, type: type, participants: participants, price: price, key: key)
            return activity
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
