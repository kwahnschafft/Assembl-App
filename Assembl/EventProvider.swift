//
//  EventProvider.swift
//  FunFacts
//
//  Created by Kiara Wahnschafft on 2/18/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import GameKit

struct EventProvider {
    let events = [EventModel]()
    
    
    func randomFact() -> String {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: events.count)
        return events[randomNumber].name!
    }
}
