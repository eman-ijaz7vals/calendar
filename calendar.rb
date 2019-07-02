require 'date'
require './events'

$months_arr = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
class Calendar

  def initialize()
    years = ["2013", "2014", "2015", "2016", "2017", "2018", "2019"]
    months = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    @cal = Hash.new
    for x in years ## years hashes key
      @cal[x]  = Hash.new
      for y in months
        @cal[x][y] = Hash.new
        if y == "Feb"
          for d in (0..27) ## 28 days
            date = x +"-"+ y + "-" + (d+1).to_s
            @cal[x][y][date] = Array.new
          end
        

        elsif y == "Jan" || y == "March" || y=="May" || y=="July" || y=="Aug" || y=="Oct" || y=="Dec"
          for d in (0..30) ## 31 days
            date = x +"-"+ y + "-" + (d+1).to_s
            @cal[x][y][date] = Array.new
          end
        
        else
          for d in (0..29) ## 30 days
            date = x +"-"+ y + "-" + (d+1).to_s
            @cal[x][y][date] = Array.new
          end

        end
      end
    end
    return @cal
  end

 # User can add/remove/edit an event to a specific date in a calendar.
  def addEvent(date, event)
    month , day, year = parseDate(date) ## return format - > June , 2, 1999
    @cal[year][month][year + "-" + month + "-" + day].push(event)
    puts "Event added successfully!"
  end


  def removeEvent(date, event_details)
    month , day, year = parseDate(date) ## return format - > June , 2, 1999
    even_arr = @cal[year][month][year + "-" + month + "-" + day]
    even_arr.each do |a_event|
      if a_event.detail == event_details 
        even_arr.delete(a_event)
        puts "Event deleted successfully!"
        return
      end

    end
    puts "Event not deleted !"

  end

  def editEvent(date, old_desc, edited_event)
    month , day, year = parseDate(date) ## return format - > June , 2, 1999
    even_arr = @cal[year][month][year + "-" + month + "-" + day]
    @cal[year][month][year + "-" + month + "-" + day].each_with_index { |a_event, index|
      if a_event.detail == old_desc 
        ##### replace with original object
        puts "im going to edit event Now !!!!!!!"
        @cal[year][month][year + "-" + month + "-" + day][index] = edited_event
        puts "Event edited successfully!"
        return
      end

    }
    puts "Event not edited !"

  end


  def printMonthView(month, year) ## print number of events on each date of month // calendar style
    months_arr = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    week_day = 1
    events_size_arr = Array.new()
    first_date, first_events_arr = @cal[year][months_arr[month.to_i-1]].first
    # puts "first date is : #{first_date}"
    week_day = Date.parse(first_date).wday
    # puts "week day is : #{week_day}"
    @cal[year][months_arr[month.to_i-1]].each do |date, events|
       datee = Date.parse(date)
       events_size_arr.push(events.length)
    end

    puts "S        M        T        W        T        F        S"
    print printDates(week_day.to_i,months_arr[month.to_i-1], events_size_arr)


  end

  def printDates(week_day, month, events_size_arr)
    months_hash = {"Jan"=>1, "Feb"=>2, "March"=>3, "April"=>4, "May"=>5, "June"=>6, "July"=>7, "Aug"=>8, "Sept"=>9, "Oct"=>10, "Nov"=>11, "Dec"=>12}
    times = (8*week_day)
    range = times + week_day
    start_spaces=""
    range.times do |n|
      start_spaces = start_spaces + " "
    end

    dates = start_spaces
    if month == "Feb"
      total_days = 28
    else
      month_num = months_hash[month]
      if month_num % 2 == 0
        total_days  = 30
      else
        total_days = 31
      end
    end
    total_days.times do |i|
      
      dates = dates + (i+1).to_s + "(" + events_size_arr[i].to_s  + ")"
      if ((i+1) >= 10)
        dates += "    "
      else
        dates += "     "
      end

      week_day = week_day+ 1
      if week_day % 7 == 0
        dates += "\n"
      end
    end

    return dates

  end
  #User can print the details of events on a specific date.

  def eventDetails(date)
     month , day, year = parseDate(date)
     # puts "#{date} : \nDetails for events are : "
     events = @cal[year][month][year + "-" + month + "-" + day]
     events.each_with_index { |event, index|

      puts "#{event.printDetails()}"

     }
  end

  #User can view the details of all the events of a month.
  def allMonthEventsDetails(month, year)
    months_arr = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]

    @cal[year][months_arr[month.to_i-1]].each { |date, events_arr|

      # puts "details for events for #{date} : "
      events_arr.each_with_index { |event, index|

      puts "#{event.printDetails()}"

      }

    }
  end
  



  # def printCalendar()
  #   @cal.each {

  #   }
  # end



  def parseDate(date) ## returns  month, month date, year
    month = date.mon
    day= date.mday
    year= date.year
    months_arr = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    
    return months_arr[month-1], day.to_s, year.to_s
  end

  def fizz_buzz(number)
    number
  end

end

