//
//  ServiceCards.swift
//  BankingApp
//
//  Created by Justhateulol on 16/04/22.
//

import SwiftUI

struct ServiceCards: Identifiable{
    var id = UUID().uuidString
    var hexValue: String
    var color: Color
    var rotateCards: Bool = false
    var addToGrid: Bool = false
    var showText: Bool = false
    var removeFromView: Bool = false
}


public enum CardVendor: String {
    case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
}
