#! /usr/bin/env ruby
PREFIX_DISABLE = "__disabled__"
LENGTH_PREFIX_DISABLE = PREFIX_DISABLE.length

Dir.chdir(Dir.home + "/.mikutter/plugin")

def get_plugin_arr
    arr_disabled = Dir.glob(PREFIX_DISABLE + "*").select {|f| !File.file?(f)}
    arr_enabled = Dir.glob("*").select {|f| !File.file?(f)} - arr_disabled
    return [arr_enabled, arr_disabled]
end

def show_plugins(arr_enabled, arr_disabled)
    puts "Enabled plugins:"
    arr_enabled.each_with_index do |plugin, i|
        printf("%2d %s\n", i, plugin)
    end
    puts
    puts "Disabled plugins:"
    arr_disabled.each_with_index do |plugin, i|
        printf("%2d %s\n", i, plugin)
    end
end

loop do

    arr_enabled, arr_disabled = get_plugin_arr()

    show_plugins(arr_enabled, arr_disabled)
    puts

    puts "Type 'h' to see help."
    loop do
        print "command> "
        input = gets.chomp
        operation, number = input.split()
        number = number.to_i

        if operation == "h" or operation == "help"
            puts "h, help:"
            puts "  See this help."
            puts "e, enable [plugin number]:"
            puts "  Enable plugin numberd [plugin number]."
            puts "d, disable [plugin number]:"
            puts "  Disable plugin numberd [plugin number]."
            puts "q, quit, exit:"
            puts "  Quit this program."
        else
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
            break
        end
    end

end
