#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'

def main
  left_modifier_held = "left_modifier_held"
  right_modifier_held = "right_modifier_held"
  puts JSON.pretty_generate(
    "title" => "Home row as modifiers when held down",
    "rules" => [
      {
        "description" => "Change A/S/D/F and J/K/L/; to ⇧/⌃/⌥/⌘ and ⌘/⌥/⌃/⇧ when held down",
        "manipulators" => [
            generate_one("a", "left_shift", left_modifier_held, right_modifier_held),
            generate_one("s", "left_control", left_modifier_held, right_modifier_held),
            generate_one("d", "left_option", left_modifier_held, right_modifier_held),
            generate_one("f", "left_command", left_modifier_held, right_modifier_held),

            generate_one("j", "left_command", right_modifier_held, left_modifier_held),
            generate_one("k", "left_option", right_modifier_held, left_modifier_held),
            generate_one("l", "left_control", right_modifier_held, left_modifier_held),
            generate_one("semicolon", "left_shift", right_modifier_held, left_modifier_held),
        ],
      },
    ],
  )
end

def generate_one(from_key, to_key, set_var, unless_var)
  {
    "description" => "#{from_key} -> #{to_key} when held down",
    "type" => "basic",
    "from" => {
        "key_code" => from_key,
        "modifiers" => { },
    },
    "to_if_alone" => [
      {
        "key_code" => from_key,
      },
    ],
    "to_if_held_down" => [
        {
            "key_code" => to_key,
        },
    ],
    "to" => [
        Karabiner.set_variable(set_var, 1),
    ],
    "to_after_key_up" => [
        Karabiner.set_variable(set_var, 10),
    ],
    "conditions" => [
        Karabiner.variable_unless(unless_var, 1),
    ]
  }
end

main()