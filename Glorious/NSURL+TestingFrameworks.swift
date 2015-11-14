import Foundation

extension NSURL {
  var isSymbolicLink: Bool {
    return URLByResolvingSymlinksInPath!.absoluteString != absoluteString
  }

  /// A naive check as to whether this URL points to a Mach-O file for
  /// the framework with the given name.
  ///
  /// - parameter frameworkName: The name of the framework.
  ///                            For example: "UIKit" or "XCTest".
  func isFrameworkMachOFile(frameworkName: String) -> Bool {
    return lastPathComponent == "\(frameworkName).framework"
  }

  /// A naive check as to whether this URL is a non-symbolic reference
  /// to a public headers directory for a testing framework like
  /// SenTestingKit or XCTest.
  var isTestingFrameworkHeaderDirectory: Bool {
    guard let components = pathComponents else {
      print("Couldn't generate components for some reason.")
      abort()
    }
    return lastPathComponent == "Headers" && // Is a "Headers" directory.
      (components.contains("SenTestingKit.framework") || components.contains("XCTest.framework")) // Included in a .framework.
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

  var testingFramework: String? {
    guard let components = pathComponents else {
      print("Couldn't generate components for some reason.")
      abort()
    }

    if components.contains("SenTestingKit.framework") {
      return "SenTestingKit.framework"
    } else if components.contains("XCTest.framework") {
      return "XCTest.framework"
    } else {
      return nil
    }
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
    guard isTestingFrameworkHeaderDirectory else {
      print("Not a testing framework header directory.")
      abort()
    }
    guard let framework = testingFramework else {
      print("Not an XCTest or SenTestingKit header directory.")
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
