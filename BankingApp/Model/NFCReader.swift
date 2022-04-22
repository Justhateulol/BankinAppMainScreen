//
//  NFCReader.swift
//  BankingApp
//
//  Created by Justhateulol on 21/04/22.
//

import Foundation
import CoreNFC


class NFCReader: NSObject, NFCNDEFReaderSessionDelegate {
    
    var session: NFCNDEFReaderSession?

    func scan() {
        // Create a reader session and pass self as delegate
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.begin()
    }
    
    // MARK: delegate methods
    // Implement the NDEF reader delegate protocol.
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Error handling
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Handle received messages
    }
}

func scan() {
    // Look for ISO 14443 and ISO 15693 tags
    let session = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693], delegate: self)
    session?.begin()
}

