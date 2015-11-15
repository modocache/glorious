import Foundation

func publicHeaderDumpAllTestFrameworks(
  rootURL: NSURL,
  outputDirectoryURL: NSURL,
  frameworks: [String],
  logger: Logger) {
    let fileManager = NSFileManager.defaultManager()

    rootURL.enumerateDirectories { url in
      if url.isFrameworkHeaderDirectory(frameworks) {

        let destinationURL = url.publicHeaderDumpOutputURL(outputDirectoryURL)
        do {
          try fileManager.createDirectoryAtURL(
            destinationURL,
            withIntermediateDirectories: true,
            attributes: nil
          )
        } catch {
          logger.error("Could not create directory at \(destinationURL.absoluteString)")
          abort()
        }

        let sourceURLs: [NSURL]
        do {
          sourceURLs = try fileManager.contentsOfDirectoryAtURL(
            url,
            includingPropertiesForKeys: [NSURLIsRegularFileKey],
            options: NSDirectoryEnumerationOptions.SkipsSubdirectoryDescendants)
        } catch {
          logger.error("Could not access contents of directory at \(url.absoluteString)")
          abort()
        }

        for sourceURL in sourceURLs {
          do {
            let toURL = destinationURL.URLByAppendingPathComponent(sourceURL.lastPathComponent!)
            logger.info("\(sourceURL.absoluteString) => \(toURL.absoluteString)")
            try fileManager.copyItemAtURL(sourceURL, toURL: toURL)
          } catch {
            logger.error("Could not copy source URL \(sourceURL.absoluteString) to destination URL \(destinationURL.absoluteString)")
          }
        }
      }
    }
}
