Pod::Spec.new do |s|
          #1.
          s.name               = "FetchFileLib"
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary         = "Sort description of 'FetchFileLib' framework"
          #4.
          s.homepage        = "https://github.com/nikhil1845"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "nikhil"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/nikhil1845/FetchFile.git", :tag => "1.0.0" }
          #9.
          s.source_files     = "YLogging", "YLogging/**/*.{h,m,swift}"
    end