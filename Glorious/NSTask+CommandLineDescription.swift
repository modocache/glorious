import Foundation

extension NSTask {
  var commandLineDescription: String {
    return "\(launchPath!) \(arguments!.joinWithSeparator(" "))"
  }
}
