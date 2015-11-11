import Foundation

struct PublicHeaderDumpArguments {
  let xcodeURL: NSURL
  let outputURL: NSURL

  init(xcodePath: String, outputPath: String) {
    xcodeURL = NSURL(fileURLWithPath: xcodePath)
    outputURL = NSURL(fileURLWithPath: outputPath)
  }
}

struct ClassDumpArguments {
  let classDumpURL: NSURL
  let xcodeURL: NSURL
  let outputURL: NSURL

  init(classDumpPath: String, xcodePath: String, outputPath: String) {
    classDumpURL = NSURL(fileURLWithPath: classDumpPath)
    xcodeURL = NSURL(fileURLWithPath: xcodePath)
    outputURL = NSURL(fileURLWithPath: outputPath)
  }
}

extension Process {
  static var isPublicHeaderDump: Bool {
    return arguments.count == 3
  }

  static var publicHeaderDumpArguments: PublicHeaderDumpArguments {
    guard arguments.count == 3 else {
      print("Usage: Glorious.swift [path to Xcode.app] [path to output directory]")
      abort()
    }
    return PublicHeaderDumpArguments(
      xcodePath: arguments[1],
      outputPath: arguments[2]
    )
  }

  static var classDumpArguments: ClassDumpArguments {
    guard arguments.count == 4 else {
      print("Usage: Glorious.swift [path to class-dump executable] [path to Xcode.app] [path to output directory]")
      abort()
    }
    return ClassDumpArguments(
      classDumpPath: arguments[1],
      xcodePath: arguments[2],
      outputPath: arguments[3]
    )
  }
}
