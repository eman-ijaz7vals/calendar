require 'date'
require './events'

# $months_arr = %w[Jan Feb March April May June July Aug Sept Oct Nov Dec]
class Calendar
  def initialize
    years = %w[2013 2014 2015 2016 2017 2018 2019]
    months = %w[Jan Feb March April May June July Aug Sept Oct Nov Dec]
    odd_months = %w[Jan March May July Aug Oct Dec] ## months having 31 days
    @cal = {}
    years.each do |x| ## years hashes key
      @cal[x] = {}
      months.each do |y|
        @cal[x][y] = {}
        if y == 'Feb'
          (0..27).each do |d| ## 28 days
            date = x + '-' + y + '-' + (d + 1).to_s
            @cal[x][y][date] = []
          end
        elsif odd_months.include?(y)
          (0..30).each do |d| ## 31 days
            date = x + '-' + y + '-' + (d + 1).to_s
            @cal[x][y][date] = []
          end
        else
          (0..29).each do |d| ## 30 days
            date = x + '-' + y + '-' + (d + 1).to_s
            @cal[x][y][date] = []
          end
        end
      end
    end
    @cal
  end

  def add_event(date, event)
    month, day, year = parse_date(date) ## return format - > June , 2, 1999
    @cal[year][month][year + '-' + month + '-' + day].push(event)
    'Event added successfully!'
  end

  def remove_event(date, event_details)
    month, day, year = parse_date(date) ## return format - > June , 2, 1999
    even_arr = @cal[year][month][year + '-' + month + '-' + day]
    even_arr.each do |a_event|
      if a_event.detail == event_details
        even_arr.delete(a_event)
        return 'Event deleted successfully!'
      end
    end
    'Event not deleted !'
  end

  def edit_event(date, old_desc, new_desc)
    month, day, year = parse_date(date) ## return format - > June , 2, 1999
    event_arr = @cal[year][month][year + '-' + month + '-' + day]
    event_arr.each_with_index do |a_event, index|
      if a_event.detail == old_desc
        event_arr[index].detail = new_desc
        return 'Event edited successfully!'
      end
    end
    'Event not edited !'
  end

  # print number of events on each date of month // calendar style
  def print_month_view(month, year)
    months_arr = %w[Jan Feb March April May June July Aug Sept Oct Nov Dec]
    month = months_arr[month.to_i - 1]
    # week_day = 1
    events_size_arr = []
    first_date, _first_events_arr = @cal[year][month].first
    week_day = Date.parse(first_date).wday
    @cal[year][months_arr[month.to_i - 1]].each do |_date, events|
      events_size_arr.push(events.length)
    end
    puts 'S        M        T        W        T        F        S'
    print print_dates(week_day.to_i, month, events_size_arr)
  end

  def print_dates(week_day, month, events_size_arr)
    months_hash = {'Jan' => 1, 'Feb' => 2, 'March' => 3, 'April' => 4, 'May' => 5, 'June' => 6, 'July' => 7, 'Aug' => 8, 'Sept' => 9, 'Oct' => 10, 'Nov' => 11, 'Dec' => 12}
    times = (8 * week_day)
    range = times + week_day
    start_spaces = ''
    range.times { start_spaces += ' ' }

    dates = start_spaces
    if month == 'Feb'
      total_days = 28
    else
      month_num = months_hash[month]
      total_days = if month_num.even?
                     30
                   else
                     31
                   end
    end
    total_days.times do |i|
      dates = dates + (i + 1).to_s + '(' + events_size_arr[i].to_s + ')'
      dates += if (i + 1) >= 10
                 '    '
               else
                 '     '
               end

      week_day += 1
      dates += "\n" if (week_day % 7).zero?
    end
    dates
  end
  # User can print the details of events on a specific date.

  def event_details(date)
    month, day, year = parse_date(date)
    events = @cal[year][month][year + '-' + month + '-' + day]
    events.each_with_index do |event, _index|
      puts event.printDetails
    end
    'All events of given date are printed successfully!'
  end

  # User can view the details of all the events of a month.
  def all_month_events_details(month, year)
    months_arr = %w[Jan Feb March April May June July Aug Sept Oct Nov Dec]
    month_events = @cal[year][months_arr[month.to_i - 1]]
    month_events.each do |_date, events_arr|
      events_arr.each_with_index do |event, _index|
        puts event.printDetails
      end
    end
    'All events of given month are printed successfully!'
  end

  # returns  month, month date, year
  def parse_date(date)
    month = date.mon
    day = date.mday
    year = date.year
    months_arr = %w[Jan Feb March April May June July Aug Sept Oct Nov Dec]
    [months_arr[month - 1], day.to_s, year.to_s]
  end
end
