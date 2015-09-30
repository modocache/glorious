#!/usr/bin/env xcrun swift

import Foundation

// MARK: Constants

let MacOSXPlatform = "MacOSX.platform"
let iPhoneOSPlatform = "iPhoneOS.platform"
let iPhoneSimulatorPlatform = "iPhoneSimulator.platform"
let AppleTVOSPlatform = "AppleTVOS.platform"

// MARK: Helpers

extension NSURL {
  /// Generates the output directory path for the Mach-O file at this URL,
  /// based on the base directory ("XCTest-Headers"),
  /// plus the framework ("SenTestingKit.framework" or "XCTest.framework").
  /// Force-unwraps and aborts all over the place.
  func outputDirectoryPath(baseOutputDirectoryURL: NSURL, framework: String) -> String {
    guard let components = absoluteURL.pathComponents else {
      print("Couldn't form components from URL: \(absoluteURL)")
      abort()
    }

    var platform: String?
    if components.contains(iPhoneOSPlatform) {
      platform = iPhoneOSPlatform
    } else if components.contains(iPhoneSimulatorPlatform) {
      platform = iPhoneSimulatorPlatform
    } else if components.contains(AppleTVOSPlatform) {
      platform = AppleTVOSPlatform
    } else {
      platform = MacOSXPlatform
    }

    return baseOutputDirectoryURL
      .URLByAppendingPathComponent(framework)
      .URLByAppendingPathComponent(platform!)
      .absoluteURL.path!
  }
}

/// Runs class-dump on the given Mach-O file and outputs header files at the given path.
func classDump(classDumpExecutablePath: String, machOFilePath: String, outputDirectoryPath: String) {
  let task = NSTask()
  task.launchPath = classDumpExecutablePath
  task.arguments = ["-H", machOFilePath, "-o", outputDirectoryPath]
  task.launch()
  task.waitUntilExit()
}

/// Grabs the three arguments passed to this program or prints usage and aborts.
func parseArguments(arguments: [String]) -> (classDumpExecutablePath: String, xcodePath: String, outputDirectoryPath: String) {
  guard arguments.count == 4 else {
    print("Usage: Glorious.swift [path to class-dump executable] [path to Xcode.app] [path to output directory]")
    abort()
  }

  return (
    classDumpExecutablePath: arguments[1],
    xcodePath: arguments[2],
    outputDirectoryPath: arguments[3]
  )
}

func main() {
  let arguments = parseArguments(Process.arguments)
  let fileManager = NSFileManager.defaultManager()
  guard let enumerator = fileManager.enumeratorAtURL(
    NSURL(fileURLWithPath: arguments.xcodePath),
    includingPropertiesForKeys: [NSURLIsDirectoryKey],
    options: NSDirectoryEnumerationOptions(rawValue: 0),
    errorHandler: nil) else {
      print("Could not create file enumerator.")
      abort()
  }

  for url in enumerator {
    if url.lastPathComponent == "XCTest.framework" || url.lastPathComponent == "SenTestingKit.framework" {
      // 1. Grab abspath to framework
      let absolutePath = url.absoluteURL.path!

      // 2. Form output directory path
      let outputURL = NSURL(fileURLWithPath: arguments.outputDirectoryPath)
      let platformDir = url.outputDirectoryPath(outputURL, framework: url.lastPathComponent!)

      // 3. Run class-dump to that output path
      print("class-dump -H \(absolutePath) -o \(platformDir)")
      classDump(
        arguments.classDumpExecutablePath,
        machOFilePath: absolutePath,
        outputDirectoryPath: platformDir
      )
    }
  }
}

main()
