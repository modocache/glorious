protocol Logger {
  func debug(string: String)
  func info(string: String)
  func error(string: String)
}

struct StandardOutputLogger: Logger {
  func debug(string: String) {
    print("DEBUG: \(string)")
  }

  func info(string: String) {
    print("INFO: \(string)")
  }

  func error(string: String) {
    print("ERROR: \(string)")
  }
}
