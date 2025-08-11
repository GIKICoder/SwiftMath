import Foundation

internal class BundleHelper {
    static var resourceBundle: Bundle {
        // 首先尝试 SPM 的 Bundle.module
        #if SWIFT_PACKAGE
        if let bundleURL = Bundle.module.url(forResource: "mathFonts", withExtension: "bundle"),
           let bundle = Bundle(url: bundleURL) {
            return bundle
        }
        #endif
        
        // 然后尝试 CocoaPods 的 resource bundle
        if let bundleURL = Bundle(for: BundleHelper.self).url(forResource: "SwiftMath-pod", withExtension: "bundle"),
           let resourceBundle = Bundle(url: bundleURL),
           let mathFontsURL = resourceBundle.url(forResource: "mathFonts", withExtension: "bundle"),
           let mathFontsBundle = Bundle(url: mathFontsURL) {
            return mathFontsBundle
        }
        
        // 最后尝试直接从主bundle或当前bundle查找
        let bundles = [
            Bundle.main,
            Bundle(for: BundleHelper.self)
        ]
        
        for bundle in bundles {
            if let bundleURL = bundle.url(forResource: "mathFonts", withExtension: "bundle"),
               let mathFontsBundle = Bundle(url: bundleURL) {
                return mathFontsBundle
            }
        }
        
        fatalError("Could not find mathFonts.bundle in any bundle")
    }
}