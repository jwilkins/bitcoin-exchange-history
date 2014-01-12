#!/usr/bin/env ruby

Dir["./*.csv"].each { |fn|
  size = File.stat(fn).size
  if size > 20_971_520
    puts "splitting #{fn}"
    `split -d -b 20M #{fn} #{fn}.`
    #File.unlink(fn)
    File.rename(fn, "#{fn.orig}
  end
}


