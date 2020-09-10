#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'
require_relative '../lib/key_codes.rb'

def main
  puts JSON.pretty_generate(
    "title" => "Modifiers and arrows on home row",
    "rules" => [

      {
        "description" => "Change A/S/D/F/spacebar to ⇧/⌃/⌥/⌘/fn when press two or more keys simultaneously",
        "manipulators" => [
          generate_simultaneous(["spacebar", "a", "s", "d", "f"], "left_shift", ["left_control", "left_option", "left_command", "fn"]),

          generate_simultaneous(["spacebar", "a", "s", "d"], "left_shift", ["left_control", "left_option", "fn"]),
          generate_simultaneous(["spacebar", "a", "s", "f"], "left_shift", ["left_control", "left_command", "fn"]),
          generate_simultaneous(["spacebar", "a", "d", "f"], "left_shift", ["left_option", "left_command", "fn"]),
          generate_simultaneous(["spacebar", "s", "d", "f"], "left_control", ["left_option", "left_command", "fn"]),
          generate_simultaneous(["a", "s", "d", "f"], "left_shift", ["left_control", "left_option", "left_command"]),

          generate_simultaneous(["spacebar", "a", "s"], "left_shift", ["left_control", "fn"]),
          generate_simultaneous(["spacebar", "a", "d"], "left_shift", ["left_option", "fn"]),
          generate_simultaneous(["spacebar", "a", "f"], "left_shift", ["left_command", "fn"]),
          generate_simultaneous(["spacebar", "s", "d"], "left_control", ["left_option", "fn"]),
          generate_simultaneous(["spacebar", "s", "f"], "left_control", ["left_command", "fn"]),
          generate_simultaneous(["spacebar", "d", "f"], "left_option", ["left_command", "fn"]),
          generate_simultaneous(["a", "s", "d"], "left_shift", ["left_control", "left_option"]),
          generate_simultaneous(["a", "s", "f"], "left_shift", ["left_control", "left_command"]),
          generate_simultaneous(["a", "d", "f"], "left_shift", ["left_option", "left_command"]),
          generate_simultaneous(["s", "d", "f"], "left_control", ["left_option", "left_command"]),

          generate_simultaneous(["spacebar", "a"], "left_shift", ["fn"]),
          generate_simultaneous(["spacebar", "s"], "left_control", ["fn"]),
          generate_simultaneous(["spacebar", "d"], "left_option", ["fn"]),
          generate_simultaneous(["spacebar", "f"], "left_command", ["fn"]),
          generate_simultaneous(["a", "s"], "left_shift", ["left_control"]),
          generate_simultaneous(["a", "d"], "left_shift", ["left_option"]),
          generate_simultaneous(["a", "f"], "left_shift", ["left_command"]),
          generate_simultaneous(["s", "d"], "left_control", ["left_option"]),
          generate_simultaneous(["s", "f"], "left_control", ["left_command"]),
          generate_simultaneous(["d", "f"], "left_option", ["left_command"]),
        ],
      },

      {
        "description" => "Change S + C to \"⌃\", D + C to \"⌥\", and spacebar + G to \"fn\" when press the key pair simultaneously",
        "manipulators" => [
          generate_simultaneous(["spacebar", "g"], "fn", []),
          generate_simultaneous(["s", "c"], "left_control", []),
          generate_simultaneous(["d", "c"], "left_option", []),
        ],
      },

      {
        "description" => "Change spacebar/J/K/L/; to fn/⌘/⌥/⌃/⇧ when press two or more keys simultaneously",
        "manipulators" => [
            generate_simultaneous(["spacebar", "semicolon", "l", "k", "j"], "left_shift", ["left_control", "left_option", "left_command", "fn"]),

            generate_simultaneous(["spacebar", "semicolon", "l", "k"], "left_shift", ["left_control", "left_option", "fn"]),
            generate_simultaneous(["spacebar", "semicolon", "l", "j"], "left_shift", ["left_control", "left_command", "fn"]),
            generate_simultaneous(["spacebar", "semicolon", "k", "j"], "left_shift", ["left_option", "left_command", "fn"]),
            generate_simultaneous(["spacebar", "l", "k", "j"], "left_control", ["left_option", "left_command", "fn"]),
            generate_simultaneous(["semicolon", "l", "k", "j"], "left_shift", ["left_control", "left_option", "left_command"]),

            generate_simultaneous(["spacebar", "semicolon", "l"], "left_shift", ["left_control", "fn"]),
            generate_simultaneous(["spacebar", "semicolon", "k"], "left_shift", ["left_option", "fn"]),
            generate_simultaneous(["spacebar", "semicolon", "j"], "left_shift", ["left_command", "fn"]),
            generate_simultaneous(["spacebar", "l", "k"], "left_control", ["left_option", "fn"]),
            generate_simultaneous(["spacebar", "l", "j"], "left_control", ["left_command", "fn"]),
            generate_simultaneous(["spacebar", "k", "j"], "left_option", ["left_command", "fn"]),
            generate_simultaneous(["semicolon", "l", "k"], "left_shift", ["left_control", "left_option"]),
            generate_simultaneous(["semicolon", "l", "j"], "left_shift", ["left_control", "left_command"]),
            generate_simultaneous(["semicolon", "k", "j"], "left_shift", ["left_option", "left_command"]),
            generate_simultaneous(["l", "k", "j"], "left_control", ["left_option", "left_command"]),

            generate_simultaneous(["spacebar", "semicolon"], "left_shift", ["fn"]),
            generate_simultaneous(["spacebar", "l"], "left_control", ["fn"]),
            generate_simultaneous(["spacebar", "k"], "left_option", ["fn"]),
            generate_simultaneous(["spacebar", "j"], "left_command", ["fn"]),
            generate_simultaneous(["semicolon", "l"], "left_shift", ["left_control"]),
            generate_simultaneous(["semicolon", "k"], "left_shift", ["left_option"]),
            generate_simultaneous(["semicolon", "j"], "left_shift", ["left_command"]),
            generate_simultaneous(["l", "k"], "left_control", ["left_option"]),
            generate_simultaneous(["l", "j"], "left_control", ["left_command"]),
            generate_simultaneous(["k", "j"], "left_option", ["left_command"]),
        ],
      },

      {
        "description" => "Change K + M to \"⌥\", L + M to \"⌃\", and spacebar + H to \"fn\" when press the key pair simultaneously",
        "manipulators" => [
            generate_simultaneous(["spacebar", "h"], "fn", []),
            generate_simultaneous(["l", "m"], "left_control", []),
            generate_simultaneous(["k", "m"], "left_option", []),
        ],
      },

      {
        "description" => "Change fn + I/J/K/L/M/;/U/O/Y/P to ↑/←/↓/→/⌫/⌦/⇞/⇟/↖/↘",
        "manipulators" => [
          rebind_when_fn("i", "up_arrow"),
          rebind_when_fn("j", "left_arrow"),
          rebind_when_fn("k", "down_arrow"),
          rebind_when_fn("l", "right_arrow"),
          rebind_when_fn("m", "delete_or_backspace"),
          rebind_when_fn("semicolon", "delete_forward"),
          rebind_when_fn("u", "page_up"),
          rebind_when_fn("o", "page_down"),
          rebind_when_fn("y", "home"),
          rebind_when_fn("p", "end"),
        ],
      },

      {
        "description" => "Change fn + 1/2/3/4/5/6/7/8/9/0/-/= to F1/F2/F3/F4/F5/F6/F7/F8/F9/F10/F11/F12",
        "manipulators" => [
          rebind_when_fn("1", "f1"),
          rebind_when_fn("2", "f2"),
          rebind_when_fn("3", "f3"),
          rebind_when_fn("4", "f4"),
          rebind_when_fn("5", "f5"),
          rebind_when_fn("6", "f6"),
          rebind_when_fn("7", "f7"),
          rebind_when_fn("8", "f8"),
          rebind_when_fn("9", "f9"),
          rebind_when_fn("0", "f10"),
          rebind_when_fn("hyphen", "f11"),
          rebind_when_fn("equal_sign", "f12"),
        ],
      },

      {
        "description" => "Change fn + escape to caps_lock",
        "manipulators" => [
          rebind_when_fn("escape", "caps_lock"),
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
          "modifiers" =>
          {
            "optional" =>
            [
              "any",
            ],
          },
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

def rebind_when_fn(from_key, to_key)
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