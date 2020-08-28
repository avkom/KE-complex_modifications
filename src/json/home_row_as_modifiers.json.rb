#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'
require_relative '../lib/key_codes.rb'

def main
  left_modifier_held = "left_modifier_held"
  right_modifier_held = "right_modifier_held"
  puts JSON.pretty_generate(
    "title" => "Home row as modifiers when held down",
    "rules" => [
      {
        "description" => "Change A/S/D/F and J/K/L/; to ⇧/⌃/⌥/⌘ and ⌘/⌥/⌃/⇧ when held down",
        "manipulators" => [
            # Left hand modifiers
            generate_simultaneous(["a", "s", "d", "f"], ["left_shift", "left_control", "left_option", "left_command"], left_modifier_held),

            generate_simultaneous(["a", "s", "d"], ["left_shift", "left_control", "left_option"], left_modifier_held),
            generate_simultaneous(["a", "s", "f"], ["left_shift", "left_control", "left_command"], left_modifier_held),
            generate_simultaneous(["a", "d", "f"], ["left_shift", "left_option", "left_command"], left_modifier_held),
            generate_simultaneous(["s", "d", "f"], ["left_control", "left_option", "left_command"], left_modifier_held),

            generate_simultaneous(["a", "s"], ["left_shift", "left_control"], left_modifier_held),
            generate_simultaneous(["a", "d"], ["left_shift", "left_option"], left_modifier_held),
            generate_simultaneous(["a", "f"], ["left_shift", "left_command"], left_modifier_held),
            generate_simultaneous(["s", "d"], ["left_control", "left_option"], left_modifier_held),
            generate_simultaneous(["s", "f"], ["left_control", "left_command"], left_modifier_held),
            generate_simultaneous(["d", "f"], ["left_option", "left_command"], left_modifier_held),

            generate_one("a", "left_shift", left_modifier_held, right_modifier_held),
            generate_one("s", "left_control", left_modifier_held, right_modifier_held),
            generate_one("d", "left_option", left_modifier_held, right_modifier_held),
            generate_one("f", "left_command", left_modifier_held, right_modifier_held),

            # Right hand modifiers
            generate_simultaneous(["semicolon", "l", "k", "j"], ["left_shift", "left_control", "left_option", "left_command"], right_modifier_held),

            generate_simultaneous(["semicolon", "l", "k"], ["left_shift", "left_control", "left_option"], right_modifier_held),
            generate_simultaneous(["semicolon", "l", "j"], ["left_shift", "left_control", "left_command"], right_modifier_held),
            generate_simultaneous(["semicolon", "k", "j"], ["left_shift", "left_option", "left_command"], right_modifier_held),
            generate_simultaneous(["l", "k", "j"], ["left_control", "left_option", "left_command"], right_modifier_held),

            generate_simultaneous(["semicolon", "l"], ["left_shift", "left_control"], right_modifier_held),
            generate_simultaneous(["semicolon", "k"], ["left_shift", "left_option"], right_modifier_held),
            generate_simultaneous(["semicolon", "j"], ["left_shift", "left_command"], right_modifier_held),
            generate_simultaneous(["l", "k"], ["left_control", "left_option"], right_modifier_held),
            generate_simultaneous(["l", "j"], ["left_control", "left_command"], right_modifier_held),
            generate_simultaneous(["k", "j"], ["left_option", "left_command"], right_modifier_held),

            generate_one("semicolon", "left_shift", right_modifier_held, left_modifier_held),
            generate_one("l", "left_control", right_modifier_held, left_modifier_held),
            generate_one("k", "left_option", right_modifier_held, left_modifier_held),
            generate_one("j", "left_command", right_modifier_held, left_modifier_held),
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
        Karabiner.set_variable(set_var, 0),
    ],
    "conditions" => [
        Karabiner.variable_unless(unless_var, 1),
    ]
  }
end

def generate_simultaneous(from_keys, to_keys, set_var)
    {
      "description" => "#{from_keys.join(" + ")} -> #{to_keys.join(" + ")} when held down",
      "type" => "basic",
      "from" => {
          "simultaneous" => KeyCodes.map(*from_keys),
          "simultaneous_options" =>
           {
            "detect_key_down_uninterruptedly" => true,
            "key_down_order" => "insensitive",
            "key_up_order" => "insensitive",
            "key_up_when" => "any",
            "to_after_key_up" => [
                Karabiner.set_variable(set_var, 0),
            ]
        }
      },
      "to" => [
          Karabiner.set_variable(set_var, 1),
          {
            "key_code" => to_keys.first(),
            "modifiers" => to_keys[1, 10],
          },
      ],
    }
  end

main()