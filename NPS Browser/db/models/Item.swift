//
//  Item.swift
//  NPS Browser
//
//  Created by JK3Y on 8/4/18.
//  Copyright © 2018 JK3Y. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Item: Object {
    enum Property: String {
        case uuid,
        titleId,
        region,
        contentId,
        consoleType,
        fileType,
        name,
        pkgDirectLink,
        rap,
        downloadRapFile,
        zrif,
        requiredFw,
        lastModificationDate,
        fileSize,
        sha256,
        pk
    }
    
    dynamic var uuid                    : String = UUID().uuidString
    dynamic var titleId                 : String?
    dynamic var region                  : String?
    dynamic var contentId               : String?
    dynamic var consoleType             : String?
    dynamic var fileType                : String?
    dynamic var name                    : String?
    dynamic var pkgDirectLink           : String?
    dynamic var rap                         : String?
    dynamic var downloadRapFile             : String?
    dynamic var zrif                       : String?
    let requiredFw = RealmProperty<Float?>()
    dynamic var lastModificationDate    : Date?
    let fileSize = RealmProperty<Int64?>()
    dynamic var sha256                  : String?
    
    dynamic var pk: String = ""
    
    override static func primaryKey() -> String {
        return Item.Property.uuid.rawValue
    }
    
    convenience required init(tsvData: TSVData) {
        self.init()
        self.titleId = tsvData.titleId
        self.region = tsvData.region
        self.name = tsvData.name!
        self.pkgDirectLink = tsvData.pkgDirectLink
        self.lastModificationDate = tsvData.lastModificationDate
        self.fileSize.value = tsvData.fileSize
        self.sha256 = tsvData.sha256
        self.contentId = tsvData.contentId
        
        self.consoleType = tsvData.consoleType.rawValue
        self.fileType = tsvData.fileType.rawValue
        
        self.zrif = tsvData.zrif
        self.requiredFw.value = tsvData.requiredFw
        self.rap = tsvData.rap
        self.downloadRapFile = tsvData.downloadRapFile
        
        self.pk = "\(region!)\(fileType!)\(titleId!)\(contentId!)"
    }
    
    static public func asObject(fromObject: Item) -> Item {
        let obj = Item()
        obj.titleId = fromObject.titleId
        obj.region = fromObject.region
        obj.name = fromObject.name
        obj.pkgDirectLink = fromObject.pkgDirectLink
        obj.lastModificationDate = fromObject.lastModificationDate
        obj.fileSize.value = fromObject.fileSize.value
        obj.sha256 = fromObject.sha256
        obj.contentId = fromObject.contentId
        obj.consoleType = fromObject.consoleType
        obj.fileType = fromObject.fileType
        
        obj.zrif = fromObject.zrif
        obj.requiredFw.value = fromObject.requiredFw.value
        obj.rap = fromObject.rap
        obj.downloadRapFile = fromObject.downloadRapFile
        
        let pk: String = "\(String(describing: fromObject.region))\(String(describing: fromObject.fileType))\(String(describing: fromObject.titleId))\(String(describing: fromObject.contentId))"
        obj.pk = pk
        
        return obj
    }
}
