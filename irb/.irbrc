# frozen_string_literal: true

require "irb/ext/save-history"

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:AUTOCOMPLETE] = {
  BG_COLOR: 0,
  FG_COLOR: 15,
}
