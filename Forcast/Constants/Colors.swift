// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#414145"></span>
  /// Alpha: 100% <br/> (0x414145ff)
  internal static let black = ColorName(rgbaValue: 0x414145ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3a85af"></span>
  /// Alpha: 100% <br/> (0x3a85afff)
  internal static let blue = ColorName(rgbaValue: 0x3a85afff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a5a5a9"></span>
  /// Alpha: 100% <br/> (0xa5a5a9ff)
  internal static let gray = ColorName(rgbaValue: 0xa5a5a9ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#eb4d3d"></span>
  /// Alpha: 100% <br/> (0xeb4d3dff)
  internal static let red = ColorName(rgbaValue: 0xeb4d3dff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let white = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f4c444"></span>
  /// Alpha: 100% <br/> (0xf4c444ff)
  internal static let yellow = ColorName(rgbaValue: 0xf4c444ff)
}
// swiftlint:enable identifier_name line_length type_body_length

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
