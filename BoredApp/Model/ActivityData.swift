//
//  ActivityData.swift
//  BoredApp
//
//  Created by Виктория Григорьева on 30.11.2023.
//

import Foundation

struct ActivityData: Codable {
    let activity: String
    let type: String
    let price: Float
    let participants: Int
    let key: String
}
