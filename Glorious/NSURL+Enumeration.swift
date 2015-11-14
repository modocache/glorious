import Foundation

extension NSURL {
  /// Enumerates all directory URLs, starting from the root.
  func enumerateDirectories(closure: (NSURL) -> ()) {
    let fileManager = NSFileManager.defaultManager()
    guard let enumerator = fileManager.enumeratorAtURL(
      self,
      includingPropertiesForKeys: [NSURLIsDirectoryKey],
      options: NSDirectoryEnumerationOptions(rawValue: 0),
      errorHandler: nil) else {
        print("Could not create file enumerator.")
        abort()
    }

    for enumeratorURL in enumerator {
      guard let url = enumeratorURL as? NSURL else {
        print("Enumerator did not return NSURL.")
        abort()
      }
      if !url.isSymbolicLink {
        closure(url)
      }
    }
  }

  func enumerateTestingFrameworkHeaderDirectoryURLs(closure: (NSURL) -> ()) {
    enumerateDirectories { url in
      if url.isTestingFrameworkHeaderDirectory {
        closure(url)
      }
    }
  }
}
