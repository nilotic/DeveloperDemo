#!/usr/bin/env ruby
# DeveloperDemo.xcodeproj 를 생성한다.
#
#   · 앱 타깃 하나, 외부 의존성 없음
#   · 디스크 폴더 구조를 그대로 그룹으로 옮기고, 파일은 개별 참조로 등록한다
#     (동기화 폴더가 아니라 file reference 방식)
#
#   사용: ruby scripts/generate_project.rb

require "xcodeproj"
require "pathname"
require "fileutils"

PROJECT_DIR = Pathname.new(File.expand_path("..", __dir__))
PROJECT_PATH = PROJECT_DIR + "DeveloperDemo.xcodeproj"
NAME = "DeveloperDemo"
BUNDLE_ID = "com.example.developerdemo"
DEPLOYMENT_TARGET = "17.0"

RESOURCE_EXTENSIONS = [".xcassets", ".xcstrings"].freeze

FileUtils.rm_rf(PROJECT_PATH)
project = Xcodeproj::Project.new(PROJECT_PATH)
target = project.new_target(:application, NAME, :ios, DEPLOYMENT_TARGET)

# 디스크 구조를 그대로 그룹으로 옮긴다.
def add(project, group, directory, target)
  directory.children.sort_by { |path| [path.directory? ? 1 : 0, path.basename.to_s] }.each do |path|
    name = path.basename.to_s
    next if name.start_with?(".")

    if RESOURCE_EXTENSIONS.include?(path.extname)
      target.add_resources([group.new_file(name)])

    elsif path.directory?
      add(project, group.new_group(name, name), path, target)

    elsif path.extname == ".swift"
      target.add_file_references([group.new_file(name)])
    end
  end
end

add(project, project.new_group(NAME, NAME), PROJECT_DIR + NAME, target)

target.build_configurations.each do |configuration|
  settings = configuration.build_settings

  settings["PRODUCT_NAME"] = NAME
  settings["PRODUCT_BUNDLE_IDENTIFIER"] = BUNDLE_ID
  settings["IPHONEOS_DEPLOYMENT_TARGET"] = DEPLOYMENT_TARGET
  settings["SWIFT_VERSION"] = "5.0"
  settings["TARGETED_DEVICE_FAMILY"] = "1,2"
  settings["GENERATE_INFOPLIST_FILE"] = "YES"
  settings["INFOPLIST_KEY_UILaunchScreen_Generation"] = "YES"
  settings["INFOPLIST_KEY_UIApplicationSceneManifest_Generation"] = "YES"
  settings["INFOPLIST_KEY_UISupportedInterfaceOrientations"] =
    "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight"
  settings["INFOPLIST_KEY_CFBundleDisplayName"] = "Developer"
  settings["INFOPLIST_KEY_UIBackgroundModes"] = "remote-notification"
  settings["MARKETING_VERSION"] = "1.0.0"
  settings["CURRENT_PROJECT_VERSION"] = "1"
  settings["DEVELOPMENT_LANGUAGE"] = "ko"
  settings["CODE_SIGN_STYLE"] = "Automatic"
  settings["ENABLE_USER_SCRIPT_SANDBOXING"] = "YES"
end

project.build_configurations.each do |configuration|
  configuration.build_settings["SWIFT_VERSION"] = "5.0"
  configuration.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = DEPLOYMENT_TARGET
end

project.save

scheme = Xcodeproj::XCScheme.new
scheme.add_build_target(target)
scheme.set_launch_target(target)
scheme.save_as(PROJECT_PATH.to_s, NAME, true)

puts "#{PROJECT_PATH} 생성 완료 (소스 #{target.source_build_phase.files.count}개)"
