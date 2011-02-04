require "json"
require "erubis"
require "fileutils"

class_conversion = {
  Fixnum => "NSNumber",
  String => "NSString",
  Array => "NSArray",
  Hash => "NSArray" # probably a link
}

property_template_file = File.read('templates/property.eruby')
property_template = Erubis::Eruby.new(property_template_file)

header_file_file = File.read('templates/header.eruby')
header_file_template = Erubis::Eruby.new(header_file_file)

m_file_file = File.read('templates/m.eruby')
m_file_template = Erubis::Eruby.new(m_file_file)

FileUtils.mkdir_p("output")
Dir.chdir("input")
Dir.glob("*.json").entries.each do |file|
  contents = File.open(file).read
  little_class_name = file.split(".").first
  class_name = little_class_name.capitalize
  puts "#{file} -> out/#{class_name}.h"

  johnson = JSON.parse(contents)
  # assume the first key points to an array which has one object
  object = johnson[johnson.keys.first].first

  vars = object.each.inject([]) do |list, item|
    key, value = item
    is_id = key == "id";
    json_key = key
    key = (is_id) ? "#{little_class_name}Id" : key
    list << { :name => key, :class_name => class_conversion[value.class], :json_key => json_key, :is_id => is_id }
    list
  end

  properties = vars.inject([]) do |list, var|
    list << property_template.result(var)
    list
  end

  h_file_contents = header_file_template.result(:vars => vars, :class_name => class_name, :properties => properties, :little_class_name => class_name.downcase)
  m_file_contents = m_file_template.result(:vars => vars, :class_name => class_name, :little_class_name => little_class_name)

  h_file = File.new("../output/#{class_name}.h", "w+")
  m_file = File.new("../output/#{class_name}.m", "w+")

  h_file.puts h_file_contents
  m_file.puts m_file_contents

  puts; puts
end
