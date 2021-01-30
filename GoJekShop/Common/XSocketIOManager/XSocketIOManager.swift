//
//  XSocketIOManager.swift
//  GoJekUser
//
//  Created by Rajes on 06/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//


import UIKit
import SocketIO

typealias SocketInputTuple = (RoomKey: String, RoomID: String, listenerKey: RoomListener)

class XSocketIOManager: NSObject {
    
    static let sharedInstance = XSocketIOManager()
    
    let manager = SocketManager(socketURL: URL(string: APPConstant.socketBaseUrl)!, config: [.log(false), .compress,.reconnects(true),.forcePolling(true),.reconnectWait(5)])
    var socket: SocketIOClient?
    var connectedWithRoom = false
    var connectedRoomType: String!
    
    override init() {
        super.init()
        socket = manager.defaultSocket
    }
    
    //Connect socket
    func establishSocketConnection() {
        
        switch socket?.status ??  SocketIOStatus.notConnected {
        case .notConnected,.disconnected:
            socket?.connect()
        case .connecting,.connected:
            break
        }
    }
    
    //Disconnect socket
    func closeSocketConnection() {
        
        print("Manually disconnect socket")
        connectedWithRoom = false
        socket?.disconnect()
    }
    
    func socketIsConnected() -> Bool {
        return socket?.status == SocketIOStatus.connected ? true : false
    }
    
    func sendSocketRequest(shopId: Int, listenerType: RoomListener, completion: @escaping ()->Void) {
        if XSocketIOManager.sharedInstance.connectedWithRoom { return }
        let saltKey = APPConstant.salt_key.fromBase64() ?? ""
        BackGroundRequestManager.share.startBackGroundRequest(roomId: "room_\(saltKey)_shop_\(shopId)", listener: listenerType)
        BackGroundRequestManager.share.requestCallback = {
            completion()
            print("socket call back")
        }
    }
    
    func checkSocketRequest(inputValue: SocketInputTuple, completionHandler: @escaping() -> Void) {
        print("Socket Connected--->",socketIsConnected())
        print("listener Key for Room \(inputValue.RoomID) : \(inputValue.listenerKey.rawValue)")
        if socket?.status == SocketIOStatus.notConnected {
            establishSocketConnection()
        }
        else if !self.connectedWithRoom {
            socket?.emit(inputValue.RoomKey, inputValue.RoomID, completion: {
                print("Socket emit data success")
            })
            
            socket?.on(inputValue.listenerKey.rawValue, callback: { (data, ack) in
                print("listener status \(data)")
                self.connectedWithRoom = true
                self.connectedRoomType = inputValue.RoomID
                completionHandler()
            })
        }
    }
}
