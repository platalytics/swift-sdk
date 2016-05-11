//
//  IoTHubClient.swift
//  IoTiOSsdk
//
//  Created by Fahad on 04/05/2016.
//  Copyright © 2016 Platalytics. All rights reserved.
//

import Foundation
import Alamofire

public class HubClient{
    
    public var hub_id: String?
    private var protocols: Protocol?
    
    init(){
    }
    
    
    public func connectToHub(hub_id: String, client_name: String) -> Bool {
        
        let parameters = [
            "hub_id" : hub_id
        ]
        
        self.hub_id? = hub_id
        
        Alamofire.request(.POST, "https://122.129.79.68:3005/iot/api/hubs/connect?api_key=35454545", parameters: parameters)
                    .validate()
            .responseJSON{response in
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                    print(response.data!)
                    if let status = json["status"] as? Bool {
                        if( status  == true){
                            let objdata = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                            let data = objdata["data"] as? [String: String]
                            self.protocols? = MQTTProtocol(broker: data!["broker"]!, client_id: client_name, topic: data!["topic"]!)
                            
                        }
                    }
                    else {
                        print("login Failed")
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
        }
        
        
        
        return false
    }
    
    public func sendMessage(msg: String) -> Bool {
        return false
    }
    
    public func fetchMessage() -> String {
        return ""
    }
    
}


