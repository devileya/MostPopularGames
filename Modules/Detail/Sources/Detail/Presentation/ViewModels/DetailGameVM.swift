//
//  DetailGameVM.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

import Combine
import Core

public class DetailGameVM: ObservableObject {

    private let getDetailGameUC: GetDetailGameUC
    @Published public var isLoadingData = true
    
    public init(getDetailGameUC: GetDetailGameUC) {
        self.getDetailGameUC = getDetailGameUC
    }
    
    @Published var detailGame: DetailGameModel? = nil
    
    func getDetailGame(slug: String) {
        isLoadingData = true
        
        let request = GetDetailRequest(slug: slug)
        getDetailGameUC.execute(request: request) { detailGame in
            self.detailGame = detailGame
            self.isLoadingData = false
        }
    }
    
}

