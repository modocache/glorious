import Foundation

func classDumpAllTestFrameworks(classDumpExecutableURL: NSURL, rootURL: NSURL, outputDirectoryURL: NSURL, logger: Logger) {
  rootURL.enumerateDirectories { url in
    if url.isFrameworkMachOFile("XCTest") || url.isFrameworkMachOFile("SenTestingKit") {
      let classDumpTask = NSTask(
        classDumpExecutableURL: classDumpExecutableURL,
        machOFileURL: url,
        outputDirectoryURL: url.classDumpOutputURL(outputDirectoryURL))
      logger.info(classDumpTask.commandLineDescription)
      classDumpTask.launchAndWaitUntilExit(logger)
    }
  }
}
