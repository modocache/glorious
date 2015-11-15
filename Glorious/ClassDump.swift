import Foundation

func classDumpAllTestFrameworks(
  classDumpExecutableURL: NSURL,
  rootURL: NSURL,
  outputDirectoryURL: NSURL,
  frameworks: [String],
  logger: Logger) {
    rootURL.enumerateDirectories { url in
      if url.isFrameworkMachOFile(frameworks) {
        let classDumpTask = NSTask(
          classDumpExecutableURL: classDumpExecutableURL,
          machOFileURL: url,
          outputDirectoryURL: url.classDumpOutputURL(outputDirectoryURL))
        logger.info(classDumpTask.commandLineDescription)
        classDumpTask.launchAndWaitUntilExit(logger)
      }
    }
}
