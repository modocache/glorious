import Foundation

struct PublicHeaderDumpArguments {
  let xcodeURL: NSURL
  let outputURL: NSURL
  let frameworks: [String]
}

struct ClassDumpArguments {
  let classDumpURL: NSURL
  let xcodeURL: NSURL
  let outputURL: NSURL
  let frameworks: [String]
}

extension Process {
  static var isPublicHeaderDump: Bool {
    return arguments.count == 4
  }

  static var publicHeaderDumpArguments: PublicHeaderDumpArguments {
    guard arguments.count == 4 else {
      print("Usage: Glorious.swift [path to Xcode.app] [path to output directory] [frameworkNameOne,frameworkNameTwo]")
      abort()
    }
    return PublicHeaderDumpArguments(
      xcodeURL: NSURL(fileURLWithPath: arguments[1]),
      outputURL: NSURL(fileURLWithPath: arguments[2]),
      frameworks: arguments[3].componentsSeparatedByString(",")
    )
  }

  static var classDumpArguments: ClassDumpArguments {
    guard arguments.count == 5 else {
      print("Usage: Glorious [path to class-dump executable] [path to Xcode.app] [path to output directory] [frameworkNameOne,frameworkNameTwo]")
      abort()
    }
    return ClassDumpArguments(
      classDumpURL: NSURL(fileURLWithPath: arguments[1]),
      xcodeURL: NSURL(fileURLWithPath: arguments[2]),
      outputURL: NSURL(fileURLWithPath: arguments[3]),
      frameworks: arguments[4].componentsSeparatedByString(","))
  }
}
