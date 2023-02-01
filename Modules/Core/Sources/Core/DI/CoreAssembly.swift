//
//  CoreAssembly.swift
//  
//
//  Created by Arif Siregar on 01/02/23.
//

import Swinject

public class CoreAssembly: Assembly {
    
    public init(){}
    
    public func assemble(container: Container) {
        // Data Source
        container.register(ApiClient.self, factory: {_ in ApiClient()})
        container.register(FavoriteGameProvider.self) { _ in
            FavoriteGameProvider()
        }
    }
}

