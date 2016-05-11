//
//  MQTT.swift
//  IoTiOSsdk
//
//  Created by Fahad on 04/05/2016.
//  Copyright © 2016 Platalytics. All rights reserved.
//

import Foundation
import Moscapsule


public class MQTTProtocol: Protocol{
    
    var mqtt_client: MQTTClient?
    var received_message: String?
    var message_consumed: Bool = false
    
    init(broker: String, client_id: String, topic: String){
        let mqttConfig = MQTTConfig(clientId: client_id, host: broker, port: 1883, keepAlive: 60)
        self.mqtt_client = MQTT.newConnection(mqttConfig)
        mqtt_client?.subscribe(topic, qos: 2)
        
        mqttConfig.onMessageCallback = { mqttMessage in
            self.message_consumed = false
            self.received_message = mqttMessage.payloadString
        }
        
    }
    
    public func fetchReceivedMessage() -> String {
        if (message_consumed == false){
            message_consumed = true
            return received_message!
        }
        else{
            return ""
        }
        
    }
    
    public func sendMessage(msg: String, topic: String) -> Bool {
        mqtt_client?.publishString(msg, topic: topic, qos: 2, retain: true)
        return true
    }
    
    
}
