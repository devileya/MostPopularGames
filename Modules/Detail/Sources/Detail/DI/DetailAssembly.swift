//
//  DetailAssembly.swift
//  
//
//  Created by Arif Siregar on 01/02/23.
//

import Swinject
import Core

public class DetailAssembly: Assembly {
    
    public init(){}
    
    public func assemble(container: Container) {
        // Data Source
        container.register(DetailGameApiProtocol.self) { r in
            DetailGameAPI(client: r.resolve(ApiClient.self)!)
        }
        
        // Repositories
        container.register(DetailGameRepositoryProtocol.self) { r in
            DetailGameRepository(gameApi: r.resolve(DetailGameApiProtocol.self)!)
        }
        
        // Use Cases
        container.register(GetDetailGameUC.self) { r in
            GetDetailGame(gameRepository: r.resolve(DetailGameRepositoryProtocol.self)!)
        }
        
        // View Models
        container.register(DetailGameVM.self, factory: { r in
            DetailGameVM(getDetailGameUC: r.resolve(GetDetailGameUC.self)!)
        })
    }
}
