Pod::Spec.new do |s|
  s.name             = 'SwiftMath-pod'
  s.version          = '1.0.0'
  s.summary          = 'A Swift library for rendering beautifully typeset math equations in iOS and macOS applications.'
  
  s.description      = <<-DESC
SwiftMath provides a full Swift implementation of iosMath for displaying beautifully rendered math equations in iOS and MacOS applications. It typesets formulae written using LaTeX in a UILabel equivalent class. It uses the same typesetting rules as LaTeX and so the equations are rendered exactly as LaTeX would render them.

SwiftMath is similar to MathJax or KaTeX for the web but for native iOS or MacOS applications without having to use a UIWebView and Javascript. More importantly, it is significantly faster than using a UIWebView.
                       DESC

  s.homepage         = 'https://github.com/GIKICoder/SwiftMath'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'GIKICoder' => 'giki.biu@gmail.com' }
  s.source           = { :git => 'https://github.com/GIKICoder/SwiftMath.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.7'

  s.source_files = 'Sources/SwiftMath/**/*.swift'
  s.resource_bundles = {
    'SwiftMath-pod' => ['Sources/SwiftMath/mathFonts.bundle/**/*']
  }
  
  s.frameworks = 'Foundation', 'CoreGraphics', 'QuartzCore', 'CoreText'
  s.ios.frameworks = 'UIKit'
  
  s.requires_arc = true
end