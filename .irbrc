# frozen_string_literal: true

# require "irb/ext/save-history"

IRB.conf[:SAVE_HISTORY] = 1000

# configure autocomplete dialog colors
if defined?(Reline::Face)
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define(:default, foreground: '#cad3f5', background: '#363a4f')
    conf.define(:enhanced, foreground: '#cad3f5', background: '#5b6078')
    conf.define(:scrollbar, foreground: '#c6a0f6', background: '#181926')
  end
else
  IRB.conf[:USE_AUTOCOMPLETE] = false
end

# copy a string to the clipboard
def cp(string)
  `echo "#{string}" | pbcopy`
  puts 'copied in clipboard'
end

def bm
  # From http://blog.evanweaver.com/articles/2006/12/13/benchmark/
  # Call benchmark { } with any block and you get the wallclock runtime
  # as well as a percent change + or - from the last run
  cur = Time.now
  result = yield
  print "#{cur = Time.now - cur} seconds"
  begin
    puts " (#{(cur / $last_benchmark * 100).to_i - 100}% change)"
  rescue StandardError
    puts ''
  end
  $last_benchmark = cur
  result
end

# all available methods explaination
def h
  puts '======================================================================='
  puts 'Here are few list of pre-defined methods you can use.'
  puts '======================================================================='
  puts 'h --------------------> print this help'
  puts 'cp(str) --------------> copy string in clipboard e.g cp(lead.name)'
  puts 'bm(block) ------------> benchmark a block'
  puts '======================================================================='
end
