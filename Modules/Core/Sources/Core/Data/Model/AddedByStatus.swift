//
//  File.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

// MARK: - AddedByStatus
public struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}
