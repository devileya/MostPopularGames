//
//  File.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

// MARK: - Rating
public struct Rating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}
