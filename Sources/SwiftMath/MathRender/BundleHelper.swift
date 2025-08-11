import Foundation

internal class BundleHelper {
    static var resourceBundle: Bundle {
        // 首先尝试 SPM 的 Bundle.module (对于 .copy 资源，直接通过 Bundle.module 访问)
        #if SWIFT_PACKAGE
        if let bundleURL = Bundle.module.url(forResource: "mathFonts", withExtension: "bundle"),
           let bundle = Bundle(url: bundleURL) {
            return bundle
        }
        // 如果没找到，尝试直接返回 Bundle.module (资源可能直接在模块中)
        return Bundle.module
        #endif
        
        // CocoaPods 资源加载逻辑
        // 1. 先检查 SwiftMath-pod.bundle 内的 mathFonts.bundle
        if let resourceBundleURL = Bundle(for: BundleHelper.self).url(forResource: "SwiftMath-pod", withExtension: "bundle"),
           let resourceBundle = Bundle(url: resourceBundleURL),
           let mathFontsURL = resourceBundle.url(forResource: "mathFonts", withExtension: "bundle"),
           let mathFontsBundle = Bundle(url: mathFontsURL) {
            return mathFontsBundle
        }
        
        // 2. 检查 SwiftMath-pod.bundle 内的资源是否直接可用 (flatten structure)
        if let resourceBundleURL = Bundle(for: BundleHelper.self).url(forResource: "SwiftMath-pod", withExtension: "bundle"),
           let resourceBundle = Bundle(url: resourceBundleURL) {
            // 检查是否有字体文件直接在这个bundle中
            if resourceBundle.url(forResource: "latinmodern-math", withExtension: "otf") != nil {
                return resourceBundle
            }
        }
        
        // 3. 最后回退方案 - 直接从主bundle或当前bundle查找
        let bundles = [
            Bundle.main,
            Bundle(for: BundleHelper.self)
        ]
        
        for bundle in bundles {
            if let bundleURL = bundle.url(forResource: "mathFonts", withExtension: "bundle"),
               let mathFontsBundle = Bundle(url: bundleURL) {
                return mathFontsBundle
            }
            // 检查字体文件是否直接在bundle中
            if bundle.url(forResource: "latinmodern-math", withExtension: "otf") != nil {
                return bundle
            }
        }
        
        fatalError("Could not find mathFonts.bundle or math font resources in any bundle")
    }
}