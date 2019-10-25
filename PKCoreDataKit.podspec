
Pod::Spec.new do |spec|

  spec.name         = "PKCoreDataKit"
  spec.version      = "1.0.0"
  spec.summary      = "A framework for managing CoreData's functioality"

  spec.description  = "Framework for managing CoreData's functionality. The purpose of this library is to make interacting with core data easier, by declaring a simpler api."

  spec.homepage     = "https://github.com/panoskob91/PKCoreDataKit"

  spec.license      = { :type => 'MIT', :file => 'MIT-LICENCE.txt' }

  spec.author       = "Panagiotis  Kompotis"

  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/panoskob91/PKCoreDataKit.git", :tag => "#{spec.version}" }

  spec.source_files  = "PKCoreDataKit", "PKCoreDataKit/Public/*.{h,m}", "PKCoreDataKit/Public/**/*.{h,m}"
  spec.exclude_files = "PKCoreDataKit/Private"

  spec.public_header_files = "PKCoreDataKit/**/*.h", "PKCoreDataKit/*.h"

end
