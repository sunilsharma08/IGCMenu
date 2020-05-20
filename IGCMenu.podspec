Pod::Spec.new do |s|
  s.name         = "IGCMenu"
  s.version      = "1.2.0"
  s.summary      = "Grid and Circular Menu for iOS."
  s.description  = "IGCMenu library gives easy way to create Grid and Circular menu in app.
This is light weight and highly customisable menu. Support iOS 7 and above."
  s.homepage     = "https://github.com/sunilsharma08/IGCMenu"
  s.license      = "MIT"
  s.author       = { "Sunil Sharma" => "sunilsharma.ss08@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/sunilsharma08/IGCMenu.git", :tag => "#{s.version}" }
  s.source_files  = "IGCMenu/**/*.{h,m}"
  s.requires_arc = true
end
