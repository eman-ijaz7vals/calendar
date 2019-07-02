
require 'date'
class Events

  attr_accessor :detail
  def initialize(detail)
    @detail = detail
  end

  def printDetails()
    puts "Details :\n#{detail} "
  end

end
