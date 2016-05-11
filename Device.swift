//
//  Device.swift
//  IoTiOSsdk
//
//  Created by Fahad on 04/05/2016.
//  Copyright © 2016 Platalytics. All rights reserved.
//

import Foundation


public class Device{
    
    internal var device_id: String?
    internal var device_name: String?
    internal var device_info: String?
    internal var device_created: String?
    internal var device_hub_id: String?
    
    
    init(name: String, id: String, info: String, created: String, h_id: String){
        device_id = id
        device_name = name
        device_info = info
        device_created = created
        device_hub_id = h_id
    }
    
    init(name: String, info: String, created: String, h_id: String){
        device_name = name
        device_info = info
        device_created = created
        device_hub_id = h_id
    }
    
}