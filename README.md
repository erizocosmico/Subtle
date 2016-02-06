# Subtle
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

Mac OS X app to download subtitles for your movies and TV shows with a drag and drop.

![View of the app](http://i.imgur.com/AAVsipC.png)

You can download the compiled version of the app in [releases](https://github.com/mvader/Subtle/releases).

## Credits

* Subtle uses the amazing api of [OpenSubtitles.org](http://opensubtitles.org) to download subtitles.
* [Subtitler](https://github.com/mvader/Subtitler) as the underlying library to download subtitles.
* [MASPreferences](https://github.com/shpakovski/MASPreferences), an amazing library that makes really simple to make preference windows on Mac OS X.

## Compiling your own version

You want to compile your own version? That's fine, Subtle is and **will always be free and open source**. Clone the project, change the value of `OSUserAgent` on `Config.plist` and compile your version. That's it.

## Building the app

* Clone the repo
* `pod install`
* Build the app
