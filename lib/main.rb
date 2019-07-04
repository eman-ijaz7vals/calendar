require './calendar'
require './events'
require 'date'

date = Date.today
date1 = date.next
date2 = date1.next

e1 = Events.new('event1 description here')
e2 = Events.new('event2 description here')
e3 = Events.new('event3 description here')
e4 = Events.new('event4 description here')
e5 = Events.new('event5 description here')
c = Calendar.new
c.add_event(date, e1)
c.add_event(date, e2)
c.add_event(date, e3)
c.add_event(date1, e4)
c.add_event(date2, e5)
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
      date = Date.parse(gets.chomp)
    rescue ArgumentError
      puts 'invalid date entered! Try again!'
      retry
    end
    event = Events.new(details)
    msg = c.add_event(date, event)
    puts msg

  when '2' ## remove event
    puts 'enter event details to remove: '
    details = gets.chomp
    puts 'Define date for event (yyyy-mm-dd) : '

    begin
      date = Date.parse(gets.chomp)
    rescue ArgumentError
      puts 'invalid date entered! Try again!'
      retry
    end
    # event = Events.new(details)
    msg = c.remove_event(date, details)
    puts msg

  when '3'
    puts 'enter event details to edit: '
    old_details = gets.chomp
    puts 'enter new event details : '
    new_details = gets.chomp
    puts 'Define date for event (yyyy-mm-dd) : '
    begin
      date = Date.parse(gets.chomp)
    rescue ArgumentError
      puts 'invalid date entered! Try again!'
      retry
    end
    msg = c.edit_event(date, old_details, new_details)
    puts msg

  when '4'
    begin
      puts 'Enter month : '
      month = gets.chomp
      puts 'Enter year : '
      year = gets.chomp
      c.print_month_view(month, year)
    end

  when '5'
    puts 'Enter date (yyyy-mm-dd) to show its all events : '
    begin
      date = Date.parse(gets.chomp)
    rescue ArgumentError
      puts 'invalid date entered! Try again!'
      retry
    end
    msg = c.event_details(date)
    puts msg

  when '6'
    puts 'Enter month : '
    month = gets.chomp
    puts 'Enter year : '
    year = gets.chomp
    msg = c.all_month_events_details(month, year)
    puts msg
  else
    break
  end
end
