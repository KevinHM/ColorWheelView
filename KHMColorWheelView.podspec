Pod::Spec.new do |s|

s.name			= "KHMColorWheelView"
s.version		= "0.0.3"
s.summary		= "A lightweight color wheel view and it work fine for arbitrary shape. enjoy!"
s.homepage		= "https://github.com/KevinHM/ColorWheelView"
s.license		= "MIT"
s.author		= { "KeinHM" => "kevinxiao1919@gmail.com" }
s.source		= { :git => "https://github.com/KevinHM/ColorWheelView.git", :tag => "0.0.3" }
s.source_files	= "KHMColorWheelView", "KHMColorWheelView/KHMColorWheelView/*.{h,m}"
s.public_header_files = "KHMColorWheelView/**/*.h"
s.requires_arc	= true

s.platform		= :ios
s.platform		= :ios, "6.0"

end
