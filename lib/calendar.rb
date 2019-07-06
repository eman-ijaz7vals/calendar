require 'date'
require './events'
class Calendar
  attr_accessor :cal
  def initialize
    @cal = {}
  end

  def add_event(date, new_event)
    begin
      year = date.year.to_s
      month = date.mon.to_s
      day = date.day.to_s
      @cal[year] = {} unless @cal.key?(year)
      @cal[year][month] = {} unless @cal[year].key?(month)
      @cal[year][month][day] = [] unless @cal[year][month].key?(day)

      event_arr = @cal[year][month][day]
      event_arr.each do |event|
        raise 'error' if event.detail == new_event.detail
      end
    rescue StandardError
      puts 'Event with such details already exist! Add new event !'
      return false
    end
    @cal[date.year.to_s][date.mon.to_s][day].push(new_event)
    puts 'Event added successfully!'
    true
  end

  def remove_event(date, event_details)
    year = date.year.to_s
    month = date.mon.to_s
    day = date.day.to_s
    begin
      event_arr = @cal[year][month][day]
      event_arr.each do |event|
        if event.detail == event_details
          event_arr.delete(event)
          puts 'Event deleted successfully!'
          return true
        end
      end
      raise 'error'
    rescue StandardError
      puts 'No such event found'
      return false
    end
  end

  def edit_event(date, old_desc, new_desc)
    year = date.year.to_s
    month = date.mon.to_s
    day = date.day.to_s
    begin
      event_arr = @cal[year][month][day]
      event_arr.each_with_index do |event, index|
        if event.detail == old_desc
          event_arr[index].detail = new_desc
          puts 'Event edited!'
          return true
        end
      end
      raise 'error'
    rescue StandardError
      puts 'No such event found'
      return false
    end
  end

  # print number of events on each date of month // calendar style
  def print_month_view(month, year)
    begin
      day, _events_arr = @cal[year][month].first
      date_str = "#{year}-#{month}-#{day}"
      date = Date.parse(date_str)
      week_day = date.wday
      dates_arr = @cal[year][month].keys ## fetch all days where events exist
      puts 'S        M        T        W        T        F        S'
      print print_dates(week_day.to_i, month, dates_arr, year)
    rescue StandardError
      puts 'No event found for given month'
      return false
    end
  end

  def print_dates(week_day, month, dates_arr, year)
    times = (8 * week_day)
    range = times + week_day
    start_spaces = ''
    range.times { start_spaces += ' ' }

    dates = start_spaces
    ## return days for specific month
    total_days = get_days_in_month(month, year)
    total_days.times do |day|
      if dates_arr.include?((day + 1).to_s)
        number_of_events = @cal[year][month][(day + 1).to_s].length.to_s
        dates = "#{dates}#{(day + 1)}(#{number_of_events})"
      else
        dates = "#{dates}#{(day + 1)}   "
      end
      dates += if (day + 1) >= 10
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
    year = date.year.to_s
    month = date.mon.to_s
    day = date.day.to_s
    begin
      day_events = @cal[year][month][day]
      day_events.each do |event|
        puts event.print_details
      end
      return true
    rescue StandardError
      puts 'No event found for given date'
      return false
    end
  end

  # User can view the details of all the events of a month.
  def all_month_events_details(month, year)
    begin
      month_events = @cal[year][month]
      month_events.each do |_day, days_events|
        days_events.each do |event|
          puts event.print_details
        end
      end
      return true
    rescue StandardError
      puts 'No event found for given month! Error'
      return false
    end
  end

  def get_days_in_month(month, year)
    month_number = month.to_i
    return 29 if Date.leap?(year.to_i) && month_number == 2
    return 28 if month_number == 2
    return 30 if [4, 6, 9, 11].include?(month_number)

    31
  end
end
