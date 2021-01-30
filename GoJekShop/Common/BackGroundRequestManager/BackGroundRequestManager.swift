//
//  BackGroundRequestManager.swift
//  GoJekProvider
//
//  Created by Rajes on 02/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation

class BackGroundRequestManager {
    
    static var share = BackGroundRequestManager()
    
    private weak var timer:Timer!
    
    var requestCallback: (() -> ())? = nil
    
    func startBackGroundRequest(roomId: String, listener: RoomListener) {
        
        print("startBackGroundRequest")
        if !XSocketIOManager.sharedInstance.socketIsConnected() {
            
            XSocketIOManager.sharedInstance.establishSocketConnection()
            initiateTimerFunction(roomId: roomId, listener: listener)
            self.requestCallback?()
            
        } else if !XSocketIOManager.sharedInstance.connectedWithRoom || XSocketIOManager.sharedInstance.connectedRoomType != roomId {
            resetBackGroudTask()
            XSocketIOManager.sharedInstance.connectedWithRoom = false
            checkSocketConnection(roomID:roomId, moduleKey: listener)
        }
    }
    
    
    func initiateTimerFunction(roomId: String, listener: RoomListener) {
        let context = ["roomID": roomId,"ListenerKey": listener] as [String : Any]
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerFunction), userInfo: context, repeats: true)
            print("Background thread initiated")
        }
    }
    
    func checkSocketConnection(roomID: String, moduleKey: RoomListener) {
        
        if XSocketIOManager.sharedInstance.socketIsConnected() {
            
            if (XSocketIOManager.sharedInstance.connectedWithRoom ) { stopBackGroundRequest()
            }
            initiateCommonRoomRequest(roomID: roomID, listener: moduleKey)
            
        } else {
            
            DispatchQueue.main.async {
                XSocketIOManager.sharedInstance.establishSocketConnection()
                self.checkSocketConnection(roomID: roomID, moduleKey: moduleKey)
            }
        }
    }
    
    func initiateCommonRoomRequest(roomID: String, listener: RoomListener) {
        XSocketIOManager.sharedInstance.checkSocketRequest(inputValue: (Constant.CommonShopRoom, roomID, listener)) {
            self.requestCallback?()
        }
    }
    
    @objc func timerFunction(timerData: Timer) {
        
        print("Fire timer function")
        print("socket not connected timer alive")
        guard let context = timerData.userInfo as? [String: Any] else { return }
        if XSocketIOManager.sharedInstance.socketIsConnected() && XSocketIOManager.sharedInstance.connectedWithRoom {
            stopBackGroundRequest()
        } else {
            if let key = context["roomID"] as? String,
                let listener = context["ListenerKey"] as? RoomListener {
                startBackGroundRequest(roomId: key, listener: listener)
            }
            requestCallback?()
        }
    }
    
    func resetBackGroudTask() {
        stopBackGroundRequest()
        XSocketIOManager.sharedInstance.connectedWithRoom = false
    }
    
    func stopBackGroundRequest() {
        DispatchQueue.main.async {
            if let _ = self.timer {
                self.timer.invalidate()
                self.timer = nil
                self.stopBackGroundRequest()
                print("stopBackGroundRequest")
            }
        }
    }
}
