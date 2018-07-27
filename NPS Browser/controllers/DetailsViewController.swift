//
//  DetailsController.swift
//  NPS Browser
//
//  Created by JK3Y on 5/6/18.
//  Copyright © 2018 JK3Y. All rights reserved.
//

import Cocoa

class DetailsViewController: NSViewController {
    
    @IBOutlet weak var chkBookmark: NSButton!
    @IBOutlet weak var btnDownload: NSButton!
    @IBOutlet weak var btnDLExtraFiles: NSButton!
    
    var windowDelegate: WindowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    override var representedObject: Any? {
        didSet {
            enableDownloadAndBookmarkButtons()
            toggleBookmark()
        }
    }

    @IBAction func btnDownloadClicked(_ sender: Any) {
        sendDLData(url: getROManagedObject().value(forKey: "pkg_direct_link") as! URL)
    }
    
    @IBAction func btnDLExtraFilesClicked(_ sender: Any) {

        if (getROManagedObject().value(forKey: "type") as! String == "PSVGames") {
            let title_id = getROManagedObject().value(forKey: "title_id") as! String
            let pack = Helpers().getCoreDataIO().searchCompatPacks(searchString: title_id)
            let url = pack?.value(forKey: "download_url") as! URL
            
            if (pack != nil) {
                sendDLData(url: url)
            }
        }
        
        sendDLData(url: getROManagedObject().value(forKey: "download_rap_file") as! URL)
    }
    
    
    @IBAction func btnBookmarkToggle(_ sender: NSButton) {
        let bookmark: Bookmark = Helpers().makeBookmark(data: representedObject as! NSManagedObject)

        if (sender.state == .on) {
            Helpers().getSharedAppDelegate().bookmarkManager.addBookmark(bookmark: bookmark, item: getROManagedObject())
        } else {
            Helpers().getSharedAppDelegate().bookmarkManager.removeBookmark(bookmark)
        }
    }
    
    func toggleBookmark() {
        let bookmark = Helpers().getCoreDataIO().getRecordByUUID(entityName: "Bookmarks", uuid: getROManagedObject().value(forKey: "uuid") as! UUID)

        if ( bookmark != nil) {
            chkBookmark.state = .on
        } else {
            chkBookmark.state = .off
        }
    }
    
    func toggleBookmark(compareUUID: UUID) {
        let obj: NSUUID = getROManagedObject().value(forKey: "uuid") as! NSUUID
        if (obj.isEqual(to: (compareUUID as NSUUID))) {
            chkBookmark.state = .off
        }
    }
    
    func enableDownloadAndBookmarkButtons() {
        let link = (getROManagedObject().value(forKey: "pkg_direct_link") as! URL?)?.absoluteString
        let type = (getROManagedObject().value(forKey: "type") as! String)

        if (link == "MISSING") {
            btnDownload.isEnabled = false
            chkBookmark.isEnabled = false
        } else {
            btnDownload.isEnabled = true
            chkBookmark.isEnabled = true
        }
        
        if (type == "PS3Games" || type == "PS3DLCs" || type == "PS3Themes" || type == "PS3Avatars") {
            btnDLExtraFiles.isHidden = false
            let rap = (getROManagedObject().value(forKey: "rap") as! String)

            if (rap == "NOT REQUIRED" || rap == "UNLOCK/LICENSE BY DLC" || rap == "MISSING") {
                btnDLExtraFiles.title = rap
                btnDLExtraFiles.isEnabled = false
            } else {
                btnDLExtraFiles.title = "RAP"
                btnDLExtraFiles.isEnabled = true
            }
        }
        else if (type == "PSVGames") {
            
            let title_id = getROManagedObject().value(forKey: "title_id") as! String

            if (Helpers().getCoreDataIO().searchCompatPacks(searchString: title_id) != nil) {
                btnDLExtraFiles.isEnabled = true
                btnDLExtraFiles.title = "Compat Pack"
            } else {
                btnDLExtraFiles.isEnabled = false
            }
        } else {
            btnDLExtraFiles.isHidden = true
            
        }
    }

    func sendDLData(url: URL) {
        let obj = getROManagedObject()
        let dlItem = Helpers().makeDLItem(data: obj, download_link: url)
        
        Helpers().getSharedAppDelegate().downloadManager.addToDownloadQueue(data: dlItem)
    }
    
    func getROManagedObject() -> NSManagedObject {
        return representedObject as! NSManagedObject
    }
}
