//
//  Card.swift
//  memory game 1
//
//  Created by Kristoffer Eriksson on 2020-12-05.
//

import UIKit

class Card: NSObject, Codable {
    
    var name: String
    var type: String
    var faceUp: Bool
    
    init(name: String, type: String, faceUp: Bool){
        self.name = name
        self.type = type
        self.faceUp = faceUp
    }

}

