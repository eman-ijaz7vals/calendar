require './calendar'
require './events'
require 'date'

date = Date.today
date1 = date.next
date2 = date1.next
c = Calendar.new

loop do
  puts "\n\n\n        **** MENU ****        "
  puts '1. Add event'
  puts '2. Remove event'
  puts '3. Edit event'
  puts '4. Print the month view'
  puts '5. Print the details of events on a specific date'
  puts '6. View the details of all the events of a month'

  option = gets.chomp
  case option
  when '1' ## add event
    puts 'enter event details : '
    details = gets.chomp
    puts 'Define date for event (yyyy-mm-dd) : '
    begin
      date_str = gets.chomp
      date = Date.parse(date_str)
      raise ArgumentError unless date_str.match(/\d{4}-\d{1,2}-\d{1,2}/)
    rescue ArgumentError
      puts 'invalid date entered! Try again!'
      retry
    end
    event = Events.new(details)
    c.add_event(date, event)
   

  when '2' ## remove event
    puts 'enter event details to remove: '
    details = gets.chomp
    puts 'Define date for event (yyyy-mm-dd) : '

    begin
      date_str = gets.chomp
      date = Date.parse(date_str)
      raise ArgumentError unless date_str.match(/\d{4}-\d{1,2}-\d{1,2}/)
    rescue ArgumentError
      puts 'invalid date entered! Try again!'
      retry
    end
    c.remove_event(date, details)
    

  when '3'
    puts 'enter event details to edit: '
    old_details = gets.chomp
    puts 'enter new event details : '
    new_details = gets.chomp
    puts 'Define date for event (yyyy-mm-dd) : '
    begin
      date_str = gets.chomp
      date = Date.parse(date_str)
      raise ArgumentError unless date_str.match(/\d{4}-\d{1,2}-\d{1,2}/)
    rescue ArgumentError
      puts 'invalid date entered! Try again!'
      retry
    end
    c.edit_event(date, old_details, new_details)
    

  when '4'

      puts 'Enter month :'
      month = gets.chomp
      puts 'Enter year : '
      year = gets.chomp
      c.print_month_view(month, year)
 

  when '5'
    puts 'Enter date (yyyy-mm-dd) to show its all events : '
    begin
      date_str = gets.chomp
      date = Date.parse(date_str)
      raise ArgumentError unless date_str.match(/\d{4}-\d{1,2}-\d{1,2}/)
    rescue ArgumentError
      puts 'invalid date entered! Try again!'
      retry
    end
    c.event_details(date)
    

  when '6'
    puts 'Enter month : '
    month = gets.chomp
    puts 'Enter year : '
    year = gets.chomp
    c.all_month_events_details(month, year)
    
  else
    break
  end
end
