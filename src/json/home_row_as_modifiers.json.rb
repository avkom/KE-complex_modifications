#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'
require_relative '../lib/key_codes.rb'

def main
  arrow_mode = "arrow_mode"

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

      {
        "description" => "Change A/S/D/F/G + ␣ + I/J/K/L/M/; to ⇧/⌃/⌥/⌘/<no modifier> + ↑/←/↓/→/⌫/⌦",
        "manipulators" => [
          generate_simultaneous("a", "spacebar", "left_shift", [], arrow_mode),
          generate_simultaneous("s", "spacebar", "left_control", [], arrow_mode),
          generate_simultaneous("d", "spacebar", "left_option", [], arrow_mode),
          generate_simultaneous("f", "spacebar", "left_command", [], arrow_mode),
          generate_simultaneous("g", "spacebar", "vk_none", [], arrow_mode),

          generate_rebind_if("i", "up_arrow", arrow_mode),
          generate_rebind_if("j", "left_arrow", arrow_mode),
          generate_rebind_if("k", "down_arrow", arrow_mode),
          generate_rebind_if("l", "right_arrow", arrow_mode),
          generate_rebind_if("m", "delete_or_backspace", arrow_mode),
          generate_rebind_if("semicolon", "delete_forward", arrow_mode),
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

def generate_simultaneous(trigger_key, from_key, to_key, modifiers, set_var)
  {
    "description" => "#{trigger_key} + #{from_key} -> #{modifiers.join(" + ")} + #{to_key}",
    "type" => "basic",
    "from" => {
        "simultaneous" => [
          { "key_code" => trigger_key },
          { "key_code" => from_key },
        ],
        "simultaneous_options" =>
        {
          "detect_key_down_uninterruptedly" => true,
          "key_down_order" => "insensitive",
          "key_up_order" => "insensitive",
          "to_after_key_up" => [
              Karabiner.set_variable(set_var, 0),
          ],
        },
         "modifiers" => {
          "optional" => ["any"]
        },
    },
    "to" => [
        Karabiner.set_variable(set_var, 1),
        {
          "key_code" => to_key,
          "modifiers" => [
              *modifiers
          ]
        },
        
    ],
  }
end

def generate_rebind_if(from_key, to_key, if_var)
  {
    "description" => "#{from_key} -> #{to_key} when var is 1",  
    "type" => "basic",
      "from" => {
        "key_code" => from_key,
        "modifiers" => {
            "optional" => ["any"]
        },
      },
      "to" => [
        {
          "key_code" => to_key,
        },
      ],
      "conditions" => [
        Karabiner.variable_if(if_var, 1),
      ]
  }
end

main()