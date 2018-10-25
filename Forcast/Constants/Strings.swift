// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {
  /// Add a city
  internal static let addCity = L10n.tr("Localizable", "add_city")
  /// Cities
  internal static let cities = L10n.tr("Localizable", "cities")
  /// City
  internal static let city = L10n.tr("Localizable", "city")
  /// the east
  internal static let east = L10n.tr("Localizable", "east")
  /// the north
  internal static let north = L10n.tr("Localizable", "north")
  /// not set
  internal static let notSet = L10n.tr("Localizable", "not_set")
  /// Refresh
  internal static let refresh = L10n.tr("Localizable", "refresh")
  /// the south
  internal static let south = L10n.tr("Localizable", "south")
  /// %@ - Max: %@ - Min:%@ - Humidity: %@
  internal static func temp(_ p1: String, _ p2: String, _ p3: String, _ p4: String) -> String {
    return L10n.tr("Localizable", "temp", p1, p2, p3, p4)
  }
  /// the west
  internal static let west = L10n.tr("Localizable", "west")
  /// %@, coming from %@
  internal static func wind(_ p1: String, _ p2: String) -> String {
    return L10n.tr("Localizable", "wind", p1, p2)
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
