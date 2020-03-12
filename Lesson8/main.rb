require_relative 'railroad'
require_relative 'controllers\railroad_control'

railroad = Railroad.demo

railroad_control = RailroadControl.new(railroad)
railroad_control.main_menu
