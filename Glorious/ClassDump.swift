import Foundation

func classDumpAllTestFrameworks(classDumpExecutableURL: NSURL, rootURL: NSURL, outputDirectoryURL: NSURL, logger: Logger) {
  rootURL.enumerateTestingFrameworkMachOFileURLs { machOFileURL in
    let classDumpTask = NSTask(
      classDumpExecutableURL: classDumpExecutableURL,
      machOFileURL: machOFileURL,
      outputDirectoryURL: machOFileURL.classDumpOutputURL(outputDirectoryURL))
    logger.info(classDumpTask.commandLineDescription)
    classDumpTask.launchAndWaitUntilExit(logger)
  }
}
