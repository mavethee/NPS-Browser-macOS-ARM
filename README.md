# NPS Browser for macOS

A Swift 4 implementation of NPS Browser.

![](/Screenshots/Screen%20Shot%202018-08-12%20at%2012.53.48%20PM.png?raw=true)

## Usage
**Requires macOS 10.10+**

* Set URLs and extraction preferences in the Preferences window
* Click the refresh button in the corner of the window to pull fresh data from the server. 

## Features
* Bookmarks can be saved by clicking the star icon in the corner of the details panel.
* Downloads can be started from the bookmark list
* Downloads can be stopped and resumed at any point, they can also be resumed if the app is closed during download.
* Compatibility pack support for FW 3.61+
* Game artwork is displayed

## Removal
After moving to trash, run:
```
rm -r ~/Library/Application\ Support/JK3Y.NPS-Browser/
rm -r ~/Library/Caches/JK3Y.NPS-Browser
defaults delete JK3Y.NPS-Browser
```

## Building
Make sure you have [CocoaPods][] installed.
Open a terminal and install the dependencies:
```
pod install
```
Open the .xcworkspace file to open the project.

Build by going to Product > Build.

Export an app bundle by going to Product > Archive > Export.

#### [Changelog][]

## Thanks
* Ann0ying for app icon
* Luro02 for the [pkg2zip][] fork
* devnoname120 for [vitanpupdatelinks][]

### Dependencies
* [Realm][]
* [AlamoFire][]
* [Promises][]
* [Queuer][]
* [Fuzi][]
* [Files][]
* [Zip][]

[Download]: https://github.com/JK3Y/NPS-Browser-macOS/releases
[CocoaPods]: https://cocoapods.org
[Changelog]: https://github.com/JK3Y/NPS-Browser-macOS/blob/master/CHANGELOG.md
[pkg2zip]: https://github.com/Luro02/pkg2zip
[vitanpupdatelinks]: https://github.com/devnoname120/vitanpupdatelinks
[Realm]: https://realm.io
[AlamoFire]:https://github.com/Alamofire/Alamofire
[Promises]:https://github.com/google/promises
[Queuer]:https://github.com/FabrizioBrancati/Queuer
[Fuzi]: https://github.com/cezheng/Fuzi
[Files]: https://github.com/JohnSundell/Files
[Zip]: https://github.com/marmelroy/Zip
