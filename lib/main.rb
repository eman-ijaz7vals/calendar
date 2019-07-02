
require "./calendar"
require "./events"
require "date"

date = Date.today
date1 = date.next()
date2 = date1.next()
date3 = date2.next()
date4 = date3.next()
date5 = date4.next()


# e = Events.new("event1 description im a here")
e1 = Events.new("event1 description im a here")
e2= Events.new("event2 description im a here")
e3 = Events.new("event3 description im a here")
e4 = Events.new("event4 description im a here")
# e.printDetails()


c= Calendar.new()
c.addEvent(date, e1)
c.addEvent(date, e2)
c.addEvent(date, e3)
c.addEvent(date2, e4)


# c.printMonthView("Aug", "2019")

while 1

  puts "\n\n\n        **** MENU ****        "
  puts "1. Add event"
  puts "2. Remove event"
  puts "3. Edit event"
  puts "4. Print the month view (in a calendar style) which will show the number of events on each date."
  puts "5. Print the details of events on a specific date"
  puts "6. View the details of all the events of a month"

  option = gets.chomp
  # puts "option entered is : #{option.class} "
  case option
  when "1" ## add event
    puts "enter event details : "
    details = gets.chomp
    puts "Define date for event (yyyy-mm-dd) : "
    begin
      date = Date.parse(gets.chomp)
    rescue ArgumentError
      puts "invalid date entered! Try again!"
      retry
    end
    event = Events.new(details)
    msg= c.addEvent(date,event)
    puts msg

  when "2"## remove event
    puts "enter event details to remove: "
    details = gets.chomp
    puts "Define date for event (yyyy-mm-dd) : "

    begin
      date = Date.parse(gets.chomp)
    rescue ArgumentError
      puts "invalid date entered! Try again!"
      retry
    end
    # event = Events.new(details)
    msg = c.removeEvent(date,details) 
    puts msg

  when "3"
    puts "enter event details to edit: "
    old_details = gets.chomp
    puts "enter new event details : "
    new_details = gets.chomp
    puts "Define date for event (yyyy-mm-dd) : "
    begin
      date = Date.parse(gets.chomp)
    rescue ArgumentError
      puts "invalid date entered! Try again!"
      retry
    end
    # old_event = Events.new(old_details)
    # new_event = Events.new(new_details)
    msg = c.editEvent(date,old_details, new_details) 
    puts msg

  when "4"
    begin
      puts "Enter month : "
      month = gets.chomp
      error_catch = catch (:month_error) do
       throw :month_error if month.to_i <= 0 || month.to_i > 12 
      end
      puts "Enter year : "
      year = gets.chomp
      c.printMonthView(month, year)
    end
    


  when "5"
    puts "Enter date (yyyy-mm-dd) to show its all events : "
    begin
      date = Date.parse(gets.chomp)
    rescue ArgumentError
      puts "invalid date entered! Try again!"
      retry
    end
    msg = c.eventDetails(date)
    puts msg


  when "6"
    puts "Enter month : "
    month = gets.chomp
    puts "Enter year : "
    year = gets.chomp
    c.allMonthEventsDetails(month, year)

  else
    break
  end

end