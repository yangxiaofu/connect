//
//  MultipeerConnectivity.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/24/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol MPCManagerDelegate{
    func foundPeer()
    
    func lostPeer()
    
    func invitationWasReceived(fromPeer: String)
    
    func connectedWithPeer(peerId:MCPeerID)
    
    func didNotConnectWithPeer()
}

enum MPCManagerError:ErrorType{
    case ConnectionUnsuccessful
}


class MPCManager: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate{
    var session:MCSession!
    var peer:MCPeerID!
    var browser:MCNearbyServiceBrowser!
    var advertiser:MCNearbyServiceAdvertiser!
    var delegate:MPCManagerDelegate?
    
    var foundPeers = [MCPeerID]()
    var invitationHandler:((Bool, MCSession) -> Void)!
    
    override init(){
        super.init()
        peer = MCPeerID(displayName: card.name)
        
        session = MCSession(peer: peer)
        session.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: peer, serviceType: "bconnect-to")
        browser.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: peer, discoveryInfo: nil, serviceType: "bconnect-to")
        advertiser.delegate = self
    }
    
    
    //MARK: - BROWSER DELEGATES
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        foundPeers.append(peerID)
        
        delegate?.foundPeer()
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        for (index, aPeer) in foundPeers.enumerate(){
            if aPeer == peerID{
                foundPeers.removeAtIndex(index)
                break
            }
        }
        delegate?.lostPeer()
        
    }
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        print(error.localizedDescription)
    }
    
    //MARK: - ADVERTISER DELEGATES
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        self.invitationHandler = invitationHandler
        
        delegate?.invitationWasReceived(peerID.displayName)
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        print(error.localizedDescription)
    }
    
    //MARK: - Session Delegate
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state{
        case MCSessionState.Connected:
            print("Connected to session: \(session)")
            delegate?.connectedWithPeer(peerID)
        case MCSessionState.Connecting:
            print("Connecting to session: \(session)")
        default:
            print("Did not connect to session: \(session)")
            delegate?.didNotConnectWithPeer()
        }
    }
    
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        let dictionary:[String: AnyObject] = ["data": data, "fromPeer": peerID]
        NSNotificationCenter.defaultCenter().postNotificationName("receivedMPCDataNotification", object: dictionary)
    }
    
    //MARK: Send Data Method
    
    func sendData(dictionaryWithData dictionary: Dictionary<String, AnyObject>, toPeer targetPeer: MCPeerID) -> Bool {
        let dataToSend = NSKeyedArchiver.archivedDataWithRootObject(dictionary)
        
        let peersArray = NSArray(object: targetPeer)
        
        do {
            try session.sendData(dataToSend, toPeers: peersArray as! [MCPeerID], withMode: MCSessionSendDataMode.Reliable)
        } catch {
            return false
        }
        return true
    }
    
    
    
    
}