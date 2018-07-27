//
//  NPSModels.swift
//  NPS Browser
//
//  Created by JK3Y on 5/14/18.
//  Copyright © 2018 JK3Y. All rights reserved.
//

import Foundation

class NPSBase {
    var title_id                    : String?
    var region                      : String?
    var name                        : String?
    var pkg_direct_link             : URL?
    var last_modification_date      : Date?
    var file_size                   : Int64?
    var sha256                      : String?
    var type                        : String
    var uuid                        : UUID
    required init(_ data: TSVData) {
        title_id                    = data.title_id
        region                      = data.region
        name                        = data.name
        pkg_direct_link             = data.pkg_direct_link
        last_modification_date      = data.last_modification_date
        file_size                   = data.file_size
        sha256                      = data.sha256
        type                        = data.type
        uuid                        = data.uuid
    }
}

class PSVGame: NPSBase {
    var zrif            : String?
    var content_id      : String?
    var original_name   : String?
    var required_fw     : Float?
    var app_version     : Float?
    required init(_ data: TSVData) {
        zrif           = data.zrif
        content_id     = data.content_id
        original_name  = data.original_name
        required_fw    = data.required_fw
        app_version    = data.app_version
        super.init(data)
    }
}

class PSVUpdate: NPSBase {
    var update_version  : Float?
    var fw_version      : Float?
    var nonpdrm_mirror  : URL?
    required init(_ data: TSVData) {
        update_version = data.update_version
        fw_version     = data.fw_version
        nonpdrm_mirror = data.nonpdrm_mirror
        super.init(data)
    }
}

class PSVDLC: NPSBase {
    var zrif        : String?
    var content_id  : String?
    required init(_ data: TSVData) {
        zrif       = data.zrif
        content_id = data.content_id
        super.init(data)
    }
}

class PSVTheme: NPSBase {
    var zrif        : String?
    var content_id  : String?
    required init(_ data: TSVData) {
        zrif       = data.zrif
        content_id = data.content_id
        super.init(data)
    }
}

class PSXGame: NPSBase {
    var content_id      : String?
    var original_name   : String?
    required init(_ data: TSVData) {
        content_id     = data.content_id
        original_name  = data.original_name
        super.init(data)
    }
}

class PSPGame: NPSBase {
    var content_id          : String?
    var rap                 : String?
    var download_rap_file   : URL?
    required init(_ data: TSVData) {
        content_id         = data.content_id
        rap                = data.rap
        download_rap_file  = data.download_rap_file
        super.init(data)
    }
}

class PS3Game: NPSBase {
    var content_id          : String?
    var rap                 : String?
    var download_rap_file   : URL?
    required init(_ data: TSVData) {
        content_id         = data.content_id
        rap                = data.rap
        download_rap_file  = data.download_rap_file
        super.init(data)
    }
}

class CompatPack {
    var title_id: String
    var download_url: URL
    required init(id: String, download_url: URL) {
        self.title_id     = id
        self.download_url = download_url
    }
}

class PS3DLC: PS3Game {}
class PS3Theme: PS3Game {}
class PS3Avatar: PS3Game {}

struct TSVData {
    var title_id                : String?
    var region                  : String?
    var name                    : String?
    var pkg_direct_link         : URL?
    var last_modification_date  : Date?
    var file_size               : Int64?
    var sha256                  : String?
    var zrif                    : String?
    var content_id              : String?
    var original_name           : String?
    var required_fw             : Float?
    var update_version          : Float?
    var fw_version              : Float?
    var nonpdrm_mirror          : URL?
    var rap                     : String?
    var download_rap_file       : URL?
    var type                    : String
    var uuid                    : UUID
    var app_version             : Float?
    
    init(type: String, values: [String]) {
        self.type = type
        self.uuid = UUID()
        title_id = values[0]
        region = values[1]

        switch(type) {
        case "PSVGames":
            
            debugPrint(values)
            
            name                    = values[2]
            pkg_direct_link         = URL(string: values[3])
            zrif                    = values[4]
            content_id              = values[5]
            last_modification_date  = parseDate(dateString: values[6])
            original_name           = values[7]
            file_size               = Int64(values[8])
            sha256                  = values[9]
            required_fw             = Float(values[10])
            app_version             = Float(values[11])
            
        case "PSVUpdates":
            name                    = values[2]
            update_version          = Float(values[3])
            fw_version              = Float(values[4])
            pkg_direct_link         = URL(string: values[5])
            nonpdrm_mirror          = URL(string: values[6])
            last_modification_date  = parseDate(dateString: values[7])
            file_size               = Int64(values[8])
            sha256                  = values[9]
        case "PSVDLCs", "PSVThemes":
            name                    = values[2]
            pkg_direct_link         = URL(string: values[3])
            zrif                    = values[4]
            content_id              = values[5]
            last_modification_date  = parseDate(dateString: values[6])
            file_size               = Int64(values[7])
            sha256                  = values[8]
        case "PSXGames":
            name                    = values[2]
            pkg_direct_link         = URL(string: values[3])
            content_id              = values[4]
            last_modification_date  = parseDate(dateString: values[5])
            original_name           = values[6]
            file_size               = Int64(values[7])
            sha256                  = values[8]
        case "PSPGames":
            name                    = values[3]
            pkg_direct_link         = URL(string: values[4])
            content_id              = values[5]
            last_modification_date  = parseDate(dateString: values[6])
            rap                     = values[7]
            download_rap_file       = URL(string: values[8])
            file_size               = Int64(values[9])
            sha256                  = values[10]
        case "PS3Games", "PS3DLCs", "PS3Themes", "PS3Avatars":
            let baseURL = "https://nopaystation.com/rap2file/?"
            name                    = values[2]
            pkg_direct_link         = URL(string: values[3])
            rap                     = values[4]
            content_id              = values[5]
            last_modification_date  = parseDate(dateString: values[6])
            download_rap_file       = URL(string: "\(baseURL)&contentid=\(values[5])&rap=\(values[4])")
            file_size               = Int64(values[8])
            sha256                  = values[9]
        default:
            break
        }
    }
    
    func makeNPSObject() -> NPSBase {
        var obj: NPSBase?
        
        switch(type) {
        case "PSVGames":
            obj = PSVGame(self)
        case "PSVUpdates":
            obj = PSVUpdate(self)
        case "PSVDLCs":
            obj = PSVDLC(self)
        case "PSVThemes":
            obj = PSVTheme(self)
        case "PSXGames":
            obj = PSXGame(self)
        case "PSPGames":
            obj = PSPGame(self)
        case "PS3Games":
            obj = PS3Game(self)
        case "PS3DLCs":
            obj = PS3DLC(self)
        case "PS3Themes":
            obj = PS3Theme(self)
        case "PS3Avatars":
            obj = PS3Avatar(self)
        default:
            break
        }
        return obj!
    }
    
    func parseDate(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: dateString) else {
            return nil
        }
        return date
    }
    
    
}


