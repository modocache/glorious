import Foundation

extension NSTask {
  /// Convenience initializer for a task that calls class-dump
  /// at the given path with the given arguments.
  convenience init(classDumpExecutableURL: NSURL, machOFileURL: NSURL, outputDirectoryURL: NSURL) {
    guard let classDumpExecutablePath = classDumpExecutableURL.absoluteURL.path else {
      abort()
    }
    guard let machOFilePath = machOFileURL.absoluteURL.path else {
      abort()
    }
    guard let outputDirectoryPath = outputDirectoryURL.absoluteURL.path else {
      abort()
    }

    self.init()
    self.launchPath = classDumpExecutablePath
    self.arguments = ["-H", machOFilePath, "-o", outputDirectoryPath]
  }

  /// Convenience method that launches a task and waits for it to exit.
  /// Logger captures stdout and stderr.
  func launchAndWaitUntilExit(logger: Logger) {
    let standardOutputPipe = NSPipe()
    self.standardOutput = standardOutputPipe

    let standardErrorPipe = NSPipe()
    self.standardError = standardErrorPipe

    self.launch()
    self.waitUntilExit()

    let standardOutputData = standardOutputPipe.fileHandleForReading.readDataToEndOfFile()
    if let standardOutput = String(data: standardOutputData, encoding: NSUTF8StringEncoding) {
      if standardOutput.characters.count > 0 {
        logger.debug(standardOutput)
      }
    }
    let standardErrorData = standardErrorPipe.fileHandleForReading.readDataToEndOfFile()
    if let standardError = String(data: standardErrorData, encoding: NSUTF8StringEncoding) {
      if standardError.characters.count > 0 {
        logger.debug(standardError)
      }
    }
  }
}
