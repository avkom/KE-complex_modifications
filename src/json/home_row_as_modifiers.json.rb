#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'
require_relative '../lib/key_codes.rb'

def main
  puts JSON.pretty_generate(
    "title" => "Modifiers and arrows on home row",
    "rules" => [

      {
        "description" => "Change A/S/D/F + ␣ to ⇧/⌃/⌥/⌘ + fn",
        "manipulators" => [
          generate_simultaneous(["spacebar", "a", "s", "d", "f"], "left_shift", ["left_control", "left_option", "left_command", "fn"]),

          generate_simultaneous(["spacebar", "a", "s", "d"], "left_shift", ["left_control", "left_option", "fn"]),
          generate_simultaneous(["spacebar", "a", "s", "f"], "left_shift", ["left_control", "left_command", "fn"]),
          generate_simultaneous(["spacebar", "a", "d", "f"], "left_shift", ["left_option", "left_command", "fn"]),
          generate_simultaneous(["spacebar", "s", "d", "f"], "left_control", ["left_option", "left_command", "fn"]),

          generate_simultaneous(["spacebar", "a", "s"], "left_shift", ["left_control", "fn"]),
          generate_simultaneous(["spacebar", "a", "d"], "left_shift", ["left_option", "fn"]),
          generate_simultaneous(["spacebar", "a", "f"], "left_shift", ["left_command", "fn"]),
          generate_simultaneous(["spacebar", "s", "d"], "left_control", ["left_option", "fn"]),
          generate_simultaneous(["spacebar", "s", "f"], "left_control", ["left_command", "fn"]),
          generate_simultaneous(["spacebar", "d", "f"], "left_option", ["left_command", "fn"]),

          generate_simultaneous(["spacebar", "a"], "left_shift", ["fn"]),
          generate_simultaneous(["spacebar", "s"], "left_control", ["fn"]),
          generate_simultaneous(["spacebar", "d"], "left_option", ["fn"]),
          generate_simultaneous(["spacebar", "f"], "left_command", ["fn"]),
        ],
      },

      {
        "description" => "Change G + ␣ to fn",
        "manipulators" => [
          generate_simultaneous(["spacebar", "g"], "fn", []),
        ],
      },

      {
        "description" => "Change J/K/L/; + ␣ to ⌘/⌥/⌃/⇧ + fn",
        "manipulators" => [
            generate_simultaneous(["spacebar", "semicolon", "l", "k", "j"], "left_shift", ["left_control", "left_option", "left_command", "fn"]),

            generate_simultaneous(["spacebar", "semicolon", "l", "k"], "left_shift", ["left_control", "left_option", "fn"]),
            generate_simultaneous(["spacebar", "semicolon", "l", "j"], "left_shift", ["left_control", "left_command", "fn"]),
            generate_simultaneous(["spacebar", "semicolon", "k", "j"], "left_shift", ["left_option", "left_command", "fn"]),
            generate_simultaneous(["spacebar", "l", "k", "j"], "left_control", ["left_option", "left_command", "fn"]),

            generate_simultaneous(["spacebar", "semicolon", "l"], "left_shift", ["left_control", "fn"]),
            generate_simultaneous(["spacebar", "semicolon", "k"], "left_shift", ["left_option", "fn"]),
            generate_simultaneous(["spacebar", "semicolon", "j"], "left_shift", ["left_command", "fn"]),
            generate_simultaneous(["spacebar", "l", "k"], "left_control", ["left_option", "fn"]),
            generate_simultaneous(["spacebar", "l", "j"], "left_control", ["left_command", "fn"]),
            generate_simultaneous(["spacebar", "k", "j"], "left_option", ["left_command", "fn"]),

            generate_simultaneous(["spacebar", "semicolon"], "left_shift", ["fn"]),
            generate_simultaneous(["spacebar", "l"], "left_control", ["fn"]),
            generate_simultaneous(["spacebar", "k"], "left_option", ["fn"]),
            generate_simultaneous(["spacebar", "j"], "left_command", ["fn"]),
        ],
      },

      {
        "description" => "Change H + ␣ to fn",
        "manipulators" => [
          generate_simultaneous(["spacebar", "h"], "fn", []),
        ],
      },

      {
        "description" => "Change fn + I/J/K/L/M/;/U/O/Y/P to ↑/←/↓/→/⌫/⌦/⇞/⇟/↖/↘",
        "manipulators" => [
          generate_rebind_if("i", "up_arrow"),
          generate_rebind_if("j", "left_arrow"),
          generate_rebind_if("k", "down_arrow"),
          generate_rebind_if("l", "right_arrow"),
          generate_rebind_if("m", "delete_or_backspace"),
          generate_rebind_if("semicolon", "delete_forward"),
          generate_rebind_if("u", "page_up"),
          generate_rebind_if("o", "page_down"),
          generate_rebind_if("y", "home"),
          generate_rebind_if("p", "end"),
        ],
      },

      {
        "description" => "Change fn + 1/2/3/4/5/6/7/8/9/0/-/= to F1/.../F12",
        "manipulators" => [
          generate_rebind_if("1", "f1"),
          generate_rebind_if("2", "f2"),
          generate_rebind_if("3", "f3"),
          generate_rebind_if("4", "f4"),
          generate_rebind_if("5", "f5"),
          generate_rebind_if("6", "f6"),
          generate_rebind_if("7", "f7"),
          generate_rebind_if("8", "f8"),
          generate_rebind_if("9", "f9"),
          generate_rebind_if("0", "f10"),
          generate_rebind_if("hyphen", "f11"),
          generate_rebind_if("equal_sign", "f12"),
        ],
      },

      {
        "description" => "Change A/S/D/F to ⇧/⌃/⌥/⌘ when press 2, 3, or 4 keys simultaneously",
        "manipulators" => [
            generate_simultaneous(["a", "s", "d", "f"], "left_shift", ["left_control", "left_option", "left_command"]),

            generate_simultaneous(["a", "s", "d"], "left_shift", ["left_control", "left_option"]),
            generate_simultaneous(["a", "s", "f"], "left_shift", ["left_control", "left_command"]),
            generate_simultaneous(["a", "d", "f"], "left_shift", ["left_option", "left_command"]),
            generate_simultaneous(["s", "d", "f"], "left_control", ["left_option", "left_command"]),

            generate_simultaneous(["a", "s"], "left_shift", ["left_control"]),
            generate_simultaneous(["a", "d"], "left_shift", ["left_option"]),
            generate_simultaneous(["a", "f"], "left_shift", ["left_command"]),
            generate_simultaneous(["s", "d"], "left_control", ["left_option"]),
            generate_simultaneous(["s", "f"], "left_control", ["left_command"]),
            generate_simultaneous(["d", "f"], "left_option", ["left_command"]),
        ],
      },

      {
        "description" => "Change S+C to ⌃ and D+C to ⌥",
        "manipulators" => [
            generate_simultaneous(["s", "c"], "left_control", []),
            generate_simultaneous(["d", "c"], "left_option", []),
        ],
      },

      {
        "description" => "Change J/K/L/; to ⌘/⌥/⌃/⇧ when press 2, 3, or 4 keys simultaneously",
        "manipulators" => [
            generate_simultaneous(["semicolon", "l", "k", "j"], "left_shift", ["left_control", "left_option", "left_command"]),

            generate_simultaneous(["semicolon", "l", "k"], "left_shift", ["left_control", "left_option"]),
            generate_simultaneous(["semicolon", "l", "j"], "left_shift", ["left_control", "left_command"]),
            generate_simultaneous(["semicolon", "k", "j"], "left_shift", ["left_option", "left_command"]),
            generate_simultaneous(["l", "k", "j"], "left_control", ["left_option", "left_command"]),

            generate_simultaneous(["semicolon", "l"], "left_shift", ["left_control"]),
            generate_simultaneous(["semicolon", "k"], "left_shift", ["left_option"]),
            generate_simultaneous(["semicolon", "j"], "left_shift", ["left_command"]),
            generate_simultaneous(["l", "k"], "left_control", ["left_option"]),
            generate_simultaneous(["l", "j"], "left_control", ["left_command"]),
            generate_simultaneous(["k", "j"], "left_option", ["left_command"]),
        ],
      },

      {
        "description" => "Change K+M to ⌥ and L+M to ⌃",
        "manipulators" => [
            generate_simultaneous(["l", "m"], "left_control", []),
            generate_simultaneous(["k", "m"], "left_option", []),
        ],
      },

    ],
  )
end

def generate_simultaneous(from_keys, to_key, modifiers)
    {
      "description" => "#{from_keys.join(" + ")} -> #{modifiers.join(" + ")} + #{to_key}",
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
          "key_code" => to_key,
          "modifiers" => [
              *modifiers
          ]
        },
      ],
    }
end

def generate_rebind_if(from_key, to_key)
  {
    "description" => "fn + #{from_key} -> #{to_key}",  
    "type" => "basic",
      "from" => {
        "key_code" => from_key,
        "modifiers" => {
            "optional" => ["any"],
            "mandatory" => ["fn"],
        },
      },
      "to" => [
        {
          "key_code" => to_key,
        },
      ],
  }
end

main()