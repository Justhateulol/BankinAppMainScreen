//
//  ColorCards.swift
//  BankingApp
//
//  Created by Justhateulol on 22/04/22.
//

import SwiftUI

struct ColorCards: Identifiable{
    var id = UUID().uuidString
    var hexValue: String
    var color: Color
    var rotateCards: Bool = false
    var addToGrid: Bool = false
    var showText: Bool = false
    var removeFromView: Bool = false
}
