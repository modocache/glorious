import Foundation

extension NSURL {
  var isDirectory: Bool {
    var isDirectoryValue = ObjCBool(false)
    NSFileManager.defaultManager().fileExistsAtPath(absoluteString, isDirectory: &isDirectoryValue)
    return isDirectoryValue.boolValue
  }

  var isSymbolicLink: Bool {
    return URLByResolvingSymlinksInPath!.absoluteString != absoluteString
  }

  /// A naive check as to whether this URL points to a Mach-O file for
  /// the frameworks with the given names.
  ///
  /// - parameter frameworkName: The name of the framework.
  ///                            For example: "UIKit" or "XCTest".
  func isFrameworkMachOFile(frameworkNames: [String]) -> Bool {
    guard !isDirectory else {
      return false
    }
    guard !isSymbolicLink else {
      return false
    }

    for name in frameworkNames {
      if lastPathComponent == "\(name).framework" {
        return true
      }
    }
    return false
  }

  /// A naive check as to whether this URL is a non-symbolic reference
  /// to a public headers directory for a testing framework like
  /// SenTestingKit or XCTest.
  func isFrameworkHeaderDirectory(frameworkNames: [String]) -> Bool {
    guard let components = pathComponents else {
      print("Couldn't generate components for some reason.")
      abort()
    }
    guard isDirectory else {
      return false
    }
    guard !isSymbolicLink else {
      return false
    }
    guard lastPathComponent == "Headers" else {
      return false
    }

    for name in frameworkNames {
      if components.contains("\(name).framework") {
        return true
      }
    }

    return false
  }

  /// Returns the first path component containing ".platform"
  /// in a URL, if there is one.
  ///
  /// For example, "AppleTVSimulator.platform" or "MacOSX.platform".
  var platformPathComponent: String? {
    for component in absoluteURL.pathComponents! {
      if component.rangeOfString(".platform") != nil {
        return component
      }
    }
    return nil
  }

  var sdkPathComponent: String? {
    for component in absoluteURL.pathComponents! {
      if component.rangeOfString(".sdk") != nil {
        return component
      }
    }
    return nil
  }

  var frameworkName: String? {
    guard let components = pathComponents else {
      print("Couldn't generate components for some reason.")
      abort()
    }

    for component in components {
      if component.containsString(".framework") {
        return component
      }
    }
    return nil
  }

  func classDumpOutputURL(outputDirectoryURL: NSURL) -> NSURL {
    let outputURL = outputDirectoryURL.URLByAppendingPathComponent(lastPathComponent!)
    if let platform = platformPathComponent {
      return outputURL.URLByAppendingPathComponent(platform)
    } else {
      return outputURL
    }
  }

  func publicHeaderDumpOutputURL(outputDirectoryURL: NSURL) -> NSURL {
    guard let framework = frameworkName else {
      print("Not a framework header directory.")
      abort()
    }

    let outputURL = outputDirectoryURL.URLByAppendingPathComponent(framework)
    if let platform = platformPathComponent {
      return outputURL.URLByAppendingPathComponent(platform).URLByAppendingPathComponent("Headers")
    } else if let sdk = sdkPathComponent {
      return outputURL.URLByAppendingPathComponent(sdk).URLByAppendingPathComponent("Headers")
    } else {
      return outputURL.URLByAppendingPathComponent("Headers")
    }
  }
}
