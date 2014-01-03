#!/usr/bin/env ruby
targets = {}
path = File.dirname(__FILE__)
Dir["#{path}/*.csv.*"].each { |fn|
  if File.basename(fn) =~ /(.*)\.csv\.(\d\d)/i
    targets[$1] ||= []
    targets[$1] << "#{$1}.csv.#{$2}"
  else
    puts "no match"
  end
}

targets.keys.each { |tk|
  fn = "#{tk}.csv"
  tksort = targets[tk].sort
  if tksort.length == tksort.last[-2..-1].to_i + 1
    `cat #{tksort.join(' ')} > #{path}/#{fn}`
  else
    puts "#{tk} missing parts #{tksort.last[-2..-1] + 1} > #{tksort.length}"
  end
}


