//
//  Doviz.swift
//  MVVM-DovizApp
//
//  Created by Furkan on 12.10.2022.
//

import Foundation

// MARK: - Doviz
struct Currencies: Codable {
    let success: Bool?
    let result: [Currency]?
}

// MARK: - Result
struct Currency:Codable {
    let name, code: String?
       let buying: Double?
       let buyingstr: String?
       let selling: Double?
       let sellingstr: String?
       let rate: Double?
       let time, date, datetime: String?
       let calculated: Int?
}
