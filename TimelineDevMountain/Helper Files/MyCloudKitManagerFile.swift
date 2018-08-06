//
//  MyCloudKitManagerFile.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 8/4/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation
import CloudKit


class MyCloudKitManager {
    
    
    var subscriptionIsLocallyCached: Bool = false
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // CloudKit order of operations
        // on app launch
            // fetch changes from cloud via cloudKit
    
    func subscribeToChanges() {
        
        // subscribe to future changes
            // track changes in data and have server let our app know
        
        if (subscriptionIsLocallyCached) {
            return
        }
        
        let subscription = CKDatabaseSubscription(subscriptionID: "changes")
        
        // need to tell CloudKit what type of push to send in the event of changes present that local app needs to update
        // Create a Silent Push
        let notificationInfo = CKNotificationInfo()
        // Set only this property
        notificationInfo.shouldSendContentAvailable = true
        
        // The device does NOT neeed to prompt for user acceptance if push notification is silent as in this case
        
        subscription.notificationInfo = notificationInfo
        
        // take subscription and ask CloudKit client to save it off to the server
        
        let operation = CKModifySubscriptionsOperation(subscriptionsToSave: [subscription], subscriptionIDsToDelete: [])
        
        operation.modifySubscriptionsCompletionBlock = { (_, _, error) in
            
            guard error == nil else {
                print("There was an error when trying to locally cache changes from CloudKit servers > MyCloudKitManagerFile.swift line 49")
                return
            }
            
            self.subscriptionIsLocallyCached = true
        }
        
        self.publicDB.add(operation)
    }
    
    // make sure in app capabilities, "Background Modes" is turned "On" and "Background Fetch" & "Remote Notifications" are BOTH selected
    
    // Listen for pushes in App Delegate
    
    
    // on push from cloudkit
        // fetch changes
    func fetchSavedChanges(_ callback: () -> Void) {
        
        // which Record Zones were changed?
        // which Records were changed in those changed Record Zones?  looking for "change token(s)"
        
        var publicDBChangeToken: CKServerChangeToken?
        
        let changesOperation = CKFetchDatabaseChangesOperation(
            previousServerChangeToken: publicDBChangeToken) // first time this will be nil value
        
        changesOperation.fetchAllChanges = true
        
        changesOperation.recordZoneWithIDChangedBlock = {} // collect changed Zone IDs
        changesOperation.recordZoneWithIDWasDeletedBlock = {} // delete local cache
        changesOperation.changeTokenUpdatedBlock {} // cahche new token
        
    }
    
    
}


































