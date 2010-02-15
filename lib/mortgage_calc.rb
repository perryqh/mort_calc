$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'yaml'

module MortgageCalc
  version = YAML.load_file(File.dirname(__FILE__) + "/../Version.yml")
  VERSION = "#{version[:major]}.#{version[:minor]}.#{version[:patch]}"
end

require 'mortgage_calc/mortgage_util'