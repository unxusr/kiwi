require 'fileutils'

def make_deps(feature, step_def, support)
  DIR.mkdir "feature"
  Dir.mkdir "feature/step_def"
  Dir.mkdir "feature/support"
  FileUtils.touch "feature/support/"
end
