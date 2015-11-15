require 'shellwords'

XCODE_DIRECTORY = "/Users/bgesiak/Dropbox (Personal)/Xcode".shellescape
GLORIOUS_EXECUTABLE_PATH = "/usr/local/bin/Glorious".shellescape
TARGET_FRAMEWORKS = %w{ UIKit }
CLASS_DUMP_EXECUTABLE_PATH = "/usr/local/bin/class-dump".shellescape
CLASS_DUMP_GIT_REPOSITORY_DIRECTORY = "/Users/bgesiak/Desktop/UIKit-Class-Dump".shellescape
PUBLIC_HEADERS_GIT_REPOSITORY_DIRECTORY = "/Users/bgesiak/Desktop/UIKit-Public-Headers".shellescape

class GloriousRun
  attr_reader :glorious_executable_path
  attr_reader :git_repository_path
  attr_reader :readme_template

  def initialize(glorious_executable_path, git_repository_path, readme_template)
  	@glorious_executable_path = glorious_executable_path
  	@git_repository_path = git_repository_path
  	@readme_template = readme_template
  end

  def glorious_command(xcode_directory)
  	raise "This method must be overridden to return the Glorious command to run."
  end
end

CLASS_DUMP_README_TEMPLATE = %Q{
# #{TARGET_FRAMEWORKS.join(", ")} Class Dumps

class-dump output from each version of these frameworks that
has been shipped with Xcode over the years.
}
class ClassDumpRun < GloriousRun
  def glorious_command(xcode_directory)
  	"#{@glorious_executable_path} #{CLASS_DUMP_EXECUTABLE_PATH} #{xcode_directory} #{@git_repository_path} #{TARGET_FRAMEWORKS.join(",")}"
  end
end

PUBLIC_HEADERS_README_TEMPLATE = %Q{
# #{TARGET_FRAMEWORKS.join(", ")} Public Headers

Public headers from each version of these frameworks that
has been shipped with Xcode over the years.
}
class PublicHeadersRun < GloriousRun
  def glorious_command(xcode_directory)
  	"#{@glorious_executable_path} #{xcode_directory} #{@git_repository_path} #{TARGET_FRAMEWORKS.join(",")}"
  end
end

def print_and_execute_command(command)
  puts command
  `#{command}`
end

[
  ClassDumpRun.new(GLORIOUS_EXECUTABLE_PATH, CLASS_DUMP_GIT_REPOSITORY_DIRECTORY, CLASS_DUMP_README_TEMPLATE),
  PublicHeadersRun.new(GLORIOUS_EXECUTABLE_PATH, PUBLIC_HEADERS_GIT_REPOSITORY_DIRECTORY, PUBLIC_HEADERS_README_TEMPLATE),
].each do |glorious_run|
  print_and_execute_command("mkdir -p #{glorious_run.git_repository_path}")

  Dir.chdir("#{glorious_run.git_repository_path}") do
    `rm -rf .git`
    `rm -r *`
    `git init`
    File.open("README.md", "w") { |f| f.write(glorious_run.readme_template) }
    `git add .`
    print_and_execute_command("git commit -m \"Initial commit.\"")
  end

  Dir["#{XCODE_DIRECTORY}/*/"].each do |xcode_directory|
    commit_msg = File.basename(xcode_directory)
    tag_name = commit_msg.gsub(" ", "").gsub("(", "-").gsub(")", "")

    `rm -rf #{glorious_run.git_repository_path}/*.framework`
    print_and_execute_command("#{glorious_run.glorious_command(xcode_directory.shellescape)}")
  
    Dir.chdir("#{glorious_run.git_repository_path}") do
      `git add .`
      print_and_execute_command("git commit --allow-empty -m \"#{commit_msg}\"")
      print_and_execute_command("git tag -f \"#{tag_name}\"")
    end
  end
end
