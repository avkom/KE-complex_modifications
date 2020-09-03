#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'
require_relative '../lib/key_codes.rb'

def main
  noop_mode = "noop_mode"
  arrow_mode = "arrow_mode"

  puts JSON.pretty_generate(
    "title" => "Home row as modifiers + IJKL cursor",
    "rules" => [
      {
        "description" => "Change A/S/D/F/G + ␣ + I/J/K/L/M/;/U/O/Y/P to ⇧/⌃/⌥/⌘/<no modifier> + ↑/←/↓/→/⌫/⌦/⇞/⇟/↖/↘",
        "manipulators" => [
          generate_simultaneous(["spacebar", "a", "s", "d", "f"], "left_shift", ["left_control", "left_option", "left_command"], arrow_mode),

          generate_simultaneous(["spacebar", "a", "s", "d"], "left_shift", ["left_control", "left_option"], arrow_mode),
          generate_simultaneous(["spacebar", "a", "s", "f"], "left_shift", ["left_control", "left_command"], arrow_mode),
          generate_simultaneous(["spacebar", "a", "d", "f"], "left_shift", ["left_option", "left_command"], arrow_mode),
          generate_simultaneous(["spacebar", "s", "d", "f"], "left_control", ["left_option", "left_command"], arrow_mode),

          generate_simultaneous(["spacebar", "a", "s"], "left_shift", ["left_control"], arrow_mode),
          generate_simultaneous(["spacebar", "a", "d"], "left_shift", ["left_option"], arrow_mode),
          generate_simultaneous(["spacebar", "a", "f"], "left_shift", ["left_command"], arrow_mode),
          generate_simultaneous(["spacebar", "s", "d"], "left_control", ["left_option"], arrow_mode),
          generate_simultaneous(["spacebar", "s", "f"], "left_control", ["left_command"], arrow_mode),
          generate_simultaneous(["spacebar", "d", "f"], "left_option", ["left_command"], arrow_mode),

          generate_simultaneous(["spacebar", "a"], "left_shift", [], arrow_mode),
          generate_simultaneous(["spacebar", "s"], "left_control", [], arrow_mode),
          generate_simultaneous(["spacebar", "d"], "left_option", [], arrow_mode),
          generate_simultaneous(["spacebar", "f"], "left_command", [], arrow_mode),
          generate_simultaneous(["spacebar", "g"], "vk_none", [], arrow_mode),

          generate_rebind_if("i", "up_arrow", arrow_mode),
          generate_rebind_if("j", "left_arrow", arrow_mode),
          generate_rebind_if("k", "down_arrow", arrow_mode),
          generate_rebind_if("l", "right_arrow", arrow_mode),
          generate_rebind_if("m", "delete_or_backspace", arrow_mode),
          generate_rebind_if("semicolon", "delete_forward", arrow_mode),
          generate_rebind_if("u", "page_up", arrow_mode),
          generate_rebind_if("o", "page_down", arrow_mode),
          generate_rebind_if("y", "home", arrow_mode),
          generate_rebind_if("p", "end", arrow_mode),
        ],
      },

      {
        "description" => "Change A/S/D/F and J/K/L/; to ⇧/⌃/⌥/⌘ and ⌘/⌥/⌃/⇧ when press 2/3/4 keys simultaneously on the same side;\n S+V -> ⌃; D+V -> ⌥; K+M -> ⌥; L+M -> ⌃",
        "manipulators" => [
            # Left hand modifiers
            generate_simultaneous(["a", "s", "d", "f"], "left_shift", ["left_control", "left_option", "left_command"], noop_mode),

            generate_simultaneous(["a", "s", "d"], "left_shift", ["left_control", "left_option"], noop_mode),
            generate_simultaneous(["a", "s", "f"], "left_shift", ["left_control", "left_command"], noop_mode),
            generate_simultaneous(["a", "d", "f"], "left_shift", ["left_option", "left_command"], noop_mode),
            generate_simultaneous(["s", "d", "f"], "left_control", ["left_option", "left_command"], noop_mode),

            generate_simultaneous(["a", "s"], "left_shift", ["left_control"], noop_mode),
            generate_simultaneous(["a", "d"], "left_shift", ["left_option"], noop_mode),
            generate_simultaneous(["a", "f"], "left_shift", ["left_command"], noop_mode),
            generate_simultaneous(["s", "d"], "left_control", ["left_option"], noop_mode),
            generate_simultaneous(["s", "f"], "left_control", ["left_command"], noop_mode),
            generate_simultaneous(["d", "f"], "left_option", ["left_command"], noop_mode),

            generate_simultaneous(["s", "v"], "left_control", [], noop_mode),
            generate_simultaneous(["d", "v"], "left_option", [], noop_mode),

            # Right hand modifiers
            generate_simultaneous(["semicolon", "l", "k", "j"], "left_shift", ["left_control", "left_option", "left_command"], noop_mode),

            generate_simultaneous(["semicolon", "l", "k"], "left_shift", ["left_control", "left_option"], noop_mode),
            generate_simultaneous(["semicolon", "l", "j"], "left_shift", ["left_control", "left_command"], noop_mode),
            generate_simultaneous(["semicolon", "k", "j"], "left_shift", ["left_option", "left_command"], noop_mode),
            generate_simultaneous(["l", "k", "j"], "left_control", ["left_option", "left_command"], noop_mode),

            generate_simultaneous(["semicolon", "l"], "left_shift", ["left_control"], noop_mode),
            generate_simultaneous(["semicolon", "k"], "left_shift", ["left_option"], noop_mode),
            generate_simultaneous(["semicolon", "j"], "left_shift", ["left_command"], noop_mode),
            generate_simultaneous(["l", "k"], "left_control", ["left_option"], noop_mode),
            generate_simultaneous(["l", "j"], "left_control", ["left_command"], noop_mode),
            generate_simultaneous(["k", "j"], "left_option", ["left_command"], noop_mode),

            generate_simultaneous(["l", "m"], "left_control", [], noop_mode),
            generate_simultaneous(["k", "m"], "left_option", [], noop_mode),
        ],
      },
    ],
  )
end

def generate_simultaneous(from_keys, to_key, modifiers, set_var)
    {
      "description" => "#{from_keys.join(" + ")} -> #{modifiers.join(" + ")} + to_key",
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
            ],
           }
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