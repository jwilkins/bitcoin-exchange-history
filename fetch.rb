require 'mechanize'
require 'byebug'

base = 'http://api.bitcoincharts.com/v1/csv'
mech = Mechanize.new

sizes = {}

Dir["./*.csv"].each { |fn|
  sizes[File.basename(fn)] = File.stat(fn).size
}

page = mech.get(base)
page.body.each_line { |ll|
  if ll =~ /([\w+]*\.csv)<\/a>\s+([^\s]+)\s+([^\s]+)\s+(\d+)/
    file = $1
    url = "#{base}/#{file}"
    date = $2
    time = $3
    size = $4.to_i
    puts "#{url}/#{date}/#{time}/#{size}/#{sizes[file]}"
    if sizes[file] == size
      puts "- skipping #{file} (same size)"
    else
      puts "- fetching #{file} (#{sizes[file]} != #{size})"
      `curl -O -C - #{url}`
    end
  end
}
