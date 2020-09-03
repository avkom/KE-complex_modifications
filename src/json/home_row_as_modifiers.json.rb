#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'
require_relative '../lib/key_codes.rb'

def main
  left_modifier_held = "left_modifier_held"
  right_modifier_held = "right_modifier_held"
  spacebar_held_down = "spacebar_held_down"

  puts JSON.pretty_generate(
    "title" => "Home row as modifiers when held down",
    "rules" => [
      {
        "description" => "Change A/S/D/F and J/K/L/; to ⇧/⌃/⌥/⌘ and ⌘/⌥/⌃/⇧ when press 2/3/4 keys simultaneously on the same side; S+V -> ⌃; D+V -> ⌥; K+M -> ⌥; L+M -> ⌃",
        "manipulators" => [
            # Left hand modifiers
            generate_simultaneous_modifiers(["a", "s", "d", "f"], ["left_shift", "left_control", "left_option", "left_command"]),

            generate_simultaneous_modifiers(["a", "s", "d"], ["left_shift", "left_control", "left_option"]),
            generate_simultaneous_modifiers(["a", "s", "f"], ["left_shift", "left_control", "left_command"]),
            generate_simultaneous_modifiers(["a", "d", "f"], ["left_shift", "left_option", "left_command"]),
            generate_simultaneous_modifiers(["s", "d", "f"], ["left_control", "left_option", "left_command"]),

            generate_simultaneous_modifiers(["a", "s"], ["left_shift", "left_control"]),
            generate_simultaneous_modifiers(["a", "d"], ["left_shift", "left_option"]),
            generate_simultaneous_modifiers(["a", "f"], ["left_shift", "left_command"]),
            generate_simultaneous_modifiers(["s", "d"], ["left_control", "left_option"]),
            generate_simultaneous_modifiers(["s", "f"], ["left_control", "left_command"]),
            generate_simultaneous_modifiers(["d", "f"], ["left_option", "left_command"]),

            generate_simultaneous_modifiers(["s", "v"], ["left_control"]),
            generate_simultaneous_modifiers(["d", "v"], ["left_option"]),

            # Right hand modifiers
            generate_simultaneous_modifiers(["semicolon", "l", "k", "j"], ["left_shift", "left_control", "left_option", "left_command"]),

            generate_simultaneous_modifiers(["semicolon", "l", "k"], ["left_shift", "left_control", "left_option"]),
            generate_simultaneous_modifiers(["semicolon", "l", "j"], ["left_shift", "left_control", "left_command"]),
            generate_simultaneous_modifiers(["semicolon", "k", "j"], ["left_shift", "left_option", "left_command"]),
            generate_simultaneous_modifiers(["l", "k", "j"], ["left_control", "left_option", "left_command"]),

            generate_simultaneous_modifiers(["semicolon", "l"], ["left_shift", "left_control"]),
            generate_simultaneous_modifiers(["semicolon", "k"], ["left_shift", "left_option"]),
            generate_simultaneous_modifiers(["semicolon", "j"], ["left_shift", "left_command"]),
            generate_simultaneous_modifiers(["l", "k"], ["left_control", "left_option"]),
            generate_simultaneous_modifiers(["l", "j"], ["left_control", "left_command"]),
            generate_simultaneous_modifiers(["k", "j"], ["left_option", "left_command"]),

            generate_simultaneous_modifiers(["l", "m"], ["left_control"]),
            generate_simultaneous_modifiers(["k", "m"], ["left_option"]),
        ],
      },
    ],
  )
end

def generate_simultaneous_modifiers(from_keys, to_keys)
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
        }
      },
      "to" => [
          {
            "key_code" => to_keys.first(),
            "modifiers" => to_keys[1, 10],
          },
      ],
    }
end

main()