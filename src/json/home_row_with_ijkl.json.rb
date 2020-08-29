#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'
require_relative '../lib/key_codes.rb'

def main
  arrow_mode = "arrow_mode"

  puts JSON.pretty_generate(
    "title" => "ASDF + IJKL as arrows with modifiers",
    "rules" => [
      {
        "description" => "Change A/S/D/F/G + I/J/K/L/M/; to ⇧/⌃/⌥/⌘/<no modifier> + ↑/←/↓/→/⌫/⌦",
        "manipulators" => [
            generate_simultaneous_modifiers(["a", "s", "d", "f"], ["left_shift", "left_control", "left_option", "left_command"], arrow_mode),

            generate_simultaneous_modifiers(["a", "s", "d"], ["left_shift", "left_control", "left_option"], arrow_mode),
            generate_simultaneous_modifiers(["a", "s", "f"], ["left_shift", "left_control", "left_command"], arrow_mode),
            generate_simultaneous_modifiers(["a", "d", "f"], ["left_shift", "left_option", "left_command"], arrow_mode),
            generate_simultaneous_modifiers(["s", "d", "f"], ["left_control", "left_option", "left_command"], arrow_mode),

            generate_simultaneous_modifiers(["a", "s"], ["left_shift", "left_control"], arrow_mode),
            generate_simultaneous_modifiers(["a", "d"], ["left_shift", "left_option"], arrow_mode),
            generate_simultaneous_modifiers(["a", "f"], ["left_shift", "left_command"], arrow_mode),
            generate_simultaneous_modifiers(["s", "d"], ["left_control", "left_option"], arrow_mode),
            generate_simultaneous_modifiers(["s", "f"], ["left_control", "left_command"], arrow_mode),
            generate_simultaneous_modifiers(["d", "f"], ["left_option", "left_command"], arrow_mode),
            
            generate_rebind_if("i", "up_arrow", arrow_mode),
            generate_rebind_if("j", "left_arrow", arrow_mode),
            generate_rebind_if("k", "down_arrow", arrow_mode),
            generate_rebind_if("l", "right_arrow", arrow_mode),
            generate_rebind_if("m", "delete_or_backspace", arrow_mode),
            generate_rebind_if("semicolon", "delete_forward", arrow_mode),

            generate_simultaneous("a", "i", "up_arrow", ["left_shift"], arrow_mode),
            generate_simultaneous("a", "j", "left_arrow", ["left_shift"], arrow_mode),
            generate_simultaneous("a", "k", "down_arrow", ["left_shift"], arrow_mode),
            generate_simultaneous("a", "l", "right_arrow", ["left_shift"], arrow_mode),
            generate_simultaneous("a", "m", "delete_or_backspace", ["left_shift"], arrow_mode),
            generate_simultaneous("a", "semicolon", "delete_forward", ["left_shift"], arrow_mode),

            generate_simultaneous("s", "i", "up_arrow", ["left_control"], arrow_mode),
            generate_simultaneous("s", "j", "left_arrow", ["left_control"], arrow_mode),
            generate_simultaneous("s", "k", "down_arrow", ["left_control"], arrow_mode),
            generate_simultaneous("s", "l", "right_arrow", ["left_control"], arrow_mode),
            generate_simultaneous("s", "m", "delete_or_backspace", ["left_control"], arrow_mode),
            generate_simultaneous("s", "semicolon", "delete_forward", ["left_control"], arrow_mode),

            generate_simultaneous("d", "i", "up_arrow", ["left_option"], arrow_mode),
            generate_simultaneous("d", "j", "left_arrow", ["left_option"], arrow_mode),
            generate_simultaneous("d", "k", "down_arrow", ["left_option"], arrow_mode),
            generate_simultaneous("d", "l", "right_arrow", ["left_option"], arrow_mode),
            generate_simultaneous("d", "m", "delete_or_backspace", ["left_option"], arrow_mode),
            generate_simultaneous("d", "semicolon", "delete_forward", ["left_option"], arrow_mode),

            generate_simultaneous("f", "i", "up_arrow", ["left_command"], arrow_mode),
            generate_simultaneous("f", "j", "left_arrow", ["left_command"], arrow_mode),
            generate_simultaneous("f", "k", "down_arrow", ["left_command"], arrow_mode),
            generate_simultaneous("f", "l", "right_arrow", ["left_command"], arrow_mode),
            generate_simultaneous("f", "m", "delete_or_backspace", ["left_command"], arrow_mode),
            generate_simultaneous("f", "semicolon", "delete_forward", ["left_command"], arrow_mode),

            generate_simultaneous("g", "i", "up_arrow", [], arrow_mode),
            generate_simultaneous("g", "j", "left_arrow", [], arrow_mode),
            generate_simultaneous("g", "k", "down_arrow", [], arrow_mode),
            generate_simultaneous("g", "l", "right_arrow", [], arrow_mode),
            generate_simultaneous("g", "m", "delete_or_backspace", [], arrow_mode),
            generate_simultaneous("g", "semicolon", "delete_forward", [], arrow_mode),
        ],
      },
    ],
  )
end

def generate_simultaneous_modifiers(from_keys, to_keys, set_var)
    {
      "description" => "#{from_keys.join(" + ")} -> #{to_keys.join(" + ")}",
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