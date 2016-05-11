//
//  Protocol.swift
//  IoTiOSsdk
//
//  Created by Fahad on 04/05/2016.
//  Copyright © 2016 Platalytics. All rights reserved.
//

import Foundation

public protocol Protocol{
    
    func fetchReceivedMessage() -> String
    func sendMessage(msg: String, topic: String) -> Bool
    
}
