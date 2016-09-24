#! /usr/bin/env ruby
PREFIX_DISABLE = "__disabled__"
LENGTH_PREFIX_DISABLE = PREFIX_DISABLE.length

Dir.chdir(Dir.home + "/.mikutter/plugin")
arr_disabled = Dir.glob(PREFIX_DISABLE + "*")
arr_enabled = Dir.glob("*") - arr_disabled

puts "Enabled plugins:"
arr_enabled.each_with_index do |plugin, i|
    printf("%2d %s\n", i, plugin)
end
puts
puts "Disabled plugins:"
arr_disabled.each_with_index do |plugin, i|
    printf("%2d %s\n", i, plugin)
end

input = gets.chomp
operation, number = input.split()
number = number.to_i
case operation
when "e", "enable"
    plugin_name = arr_disabled[number]
    File.rename(plugin_name, plugin_name[LENGTH_PREFIX_DISABLE, plugin_name.length - 1])
    puts "Enabled " + plugin_name[LENGTH_PREFIX_DISABLE, plugin_name.length - 1]
when "d", "disable"
    plugin_name = arr_enabled[number]
    File.rename(plugin_name, PREFIX_DISABLE + plugin_name)
    puts "Disabled " + plugin_name
when "q", "quit", "exit"
    exit
end
