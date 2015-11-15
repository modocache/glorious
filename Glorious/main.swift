import Foundation

let logger = StandardOutputLogger()
if Process.isPublicHeaderDump {
  let arguments = Process.publicHeaderDumpArguments
  publicHeaderDumpAllTestFrameworks(
    arguments.xcodeURL,
    outputDirectoryURL: arguments.outputURL,
    frameworks: arguments.frameworks,
    logger: logger
  )
} else {
  let arguments = Process.classDumpArguments
  classDumpAllTestFrameworks(
    arguments.classDumpURL,
    rootURL: arguments.xcodeURL,
    outputDirectoryURL: arguments.outputURL,
    frameworks: arguments.frameworks,
    logger: logger
  )
}
