//
//  RegistryManager.swift
//  IoTiOSsdk
//
//  Created by Fahad on 04/05/2016.
//  Copyright © 2016 Platalytics. All rights reserved.
//

import Foundation
import Alamofire


public class RegistryManager{
    
    public func registerDeviceBy(hub_id: String, name: String, info: String) -> Device {
        
        let parameters = [
            "name" : name,
            "hub_id" : hub_id,
            "infp" : info
        ]
        
        var new_created_device: Device?
        
        Alamofire.request(.POST, "https://122.129.79.68:3005/iot/api/devices?api_key=35454545", parameters: parameters)
            .validate()
            .responseJSON{response in
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                    print(response.data!)
                    if let status = json["status"] as? Bool {
                        if( status  == true){
                            let objdata = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                            let data = objdata["data"] as? [String: String]
                            new_created_device = Device(name: data!["name"]!, id: data!["key"]!, info: data!["info"]!, created: data!["created"]!, h_id: hub_id)
                        }
                    }
                    else {
                        print("Device Creation Failed")
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
        }
        
        return new_created_device!
    }
    
    public func registerDevice(device: Device) -> Bool {
        let parameters = [
            "name" : device.device_name!,
            "hub_id" : device.device_hub_id!,
            "infp" : device.device_info!
        ]
        
        var return_value = false
        
        Alamofire.request(.POST, "https://122.129.79.68:3005/iot/api/devices?api_key=35454545", parameters: parameters)
            .validate()
            .responseJSON{response in
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                    print(response.data!)
                    if let status = json["status"] as? Bool {
                        if( status  == true){
                            return_value = true
                        }
                    }
                    else {
                        print("Device Creation Failed")
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
        }
        return return_value
    }
    
    public func removeDevice(device_id: String) -> Bool {
        
        var return_value = false
        
        Alamofire.request(.GET, "https://122.129.79.68:3005/iot/api/devices/\(device_id)/remove?api_key=35454545")
            .validate()
            .responseJSON{response in
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                    print(response.data!)
                    if let status = json["status"] as? Bool {
                        if( status  == true){
                            return_value = true
                        }
                    }
                    else {
                        print("Device Creation Failed")
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
        }
        return return_value
    }
    
    public func getDevice(device_id: String) -> Device {
        
        var new_created_device: Device?
        
        Alamofire.request(.GET, "https://122.129.79.68:3005/iot/api/devices/\(device_id)?api_key=35454545")
            .validate()
            .responseJSON{response in
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                    print(response.data!)
                    if let status = json["status"] as? Bool {
                        if( status  == true){
                            let data = json["data"] as? [String: String]
                            new_created_device? = Device(name: data!["name"]!, id: data!["key"]!, info: data!["info"]!, created: data!["created"]!, h_id: "")
                        }
                    }
                    else {
                        print("No Such Found")
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
        }
        
        
        return new_created_device!
    }
    
    public func getAllDevice(hub_id: String) -> [Device] {
        
        var all_devices = [Device]()
        
        Alamofire.request(.GET, "https://122.129.79.68:3005/iot/api/hubs/\(hub_id)/devices?api_key=35454545")
            .validate()
            .responseJSON{response in
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                    print(response.data!)
                    if let status = json["status"] as? Bool {
                        if( status  == true){
                            let devices = json["data"] as? [[String: String]]
                            for device in devices! {
                                all_devices.append(Device(name: device["name"]!, id: device["key"]!, info: device["info"]!, created: device["created"]!, h_id: hub_id))
                            }
                        }
                        else{
                            print("No Devices Found")
                        }
                    }
                }
                catch{
                    print("error serializing JSON: \(error)")
                }
        }
        return all_devices
    }
    
}



















