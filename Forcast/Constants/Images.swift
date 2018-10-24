// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Tabbar {
    internal static let city = ImageAsset(name: "city")
    internal static let plus = ImageAsset(name: "plus")
  }
  internal enum WeatherIcon {
    internal static let brokenCloudsDay = ImageAsset(name: "broken_clouds_day")
    internal static let brokenCloudsNight = ImageAsset(name: "broken_clouds_night")
    internal static let clearSkyDay = ImageAsset(name: "clear_sky_day")
    internal static let clearSkyNight = ImageAsset(name: "clear_sky_night")
    internal static let fewCloudsDay = ImageAsset(name: "few_clouds_day")
    internal static let fewCloudsNight = ImageAsset(name: "few_clouds_night")
    internal static let mistDay = ImageAsset(name: "mist_day")
    internal static let rainDay = ImageAsset(name: "rain_day")
    internal static let rainNight = ImageAsset(name: "rain_night")
    internal static let scatteredCloudsNight = ImageAsset(name: "scattered_clouds_night")
    internal static let showerRainDay = ImageAsset(name: "shower_rain_day")
    internal static let showerRainNight = ImageAsset(name: "shower_rain_night")
    internal static let snowDay = ImageAsset(name: "snow_day")
    internal static let snowNight = ImageAsset(name: "snow_night")
    internal static let sun = ImageAsset(name: "sun")
    internal static let thunderstormDay = ImageAsset(name: "thunderstorm_day")
    internal static let thunderstormNight = ImageAsset(name: "thunderstorm_night")
  }
  internal static let starEmpty = ImageAsset(name: "starEmpty")
  internal static let starPlain = ImageAsset(name: "starPlain")

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
  ]
  internal static let allImages: [ImageAsset] = [
    Tabbar.city,
    Tabbar.plus,
    WeatherIcon.brokenCloudsDay,
    WeatherIcon.brokenCloudsNight,
    WeatherIcon.clearSkyDay,
    WeatherIcon.clearSkyNight,
    WeatherIcon.fewCloudsDay,
    WeatherIcon.fewCloudsNight,
    WeatherIcon.mistDay,
    WeatherIcon.rainDay,
    WeatherIcon.rainNight,
    WeatherIcon.scatteredCloudsNight,
    WeatherIcon.showerRainDay,
    WeatherIcon.showerRainNight,
    WeatherIcon.snowDay,
    WeatherIcon.snowNight,
    WeatherIcon.sun,
    WeatherIcon.thunderstormDay,
    WeatherIcon.thunderstormNight,
    starEmpty,
    starPlain,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  internal static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
