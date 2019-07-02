require './lib/calendar'  #will look for and test the source file in   
                           #the lib folder, called fizz_buzz.rb
# describe 'fizz_buzz' do

require "date"
#   it 'returns 1 if number is 1' do
#     expect(fizz_buzz(1)).to eq 1 
#   end

# end


describe 'Calendar' do


  c= Calendar.new()
  e1 = Events.new("event1 description")
  e2= Events.new("event2 description")
  e3 = Events.new("event3 description")
  e4 = Events.new("event4 description")
  date = Date.today
  date1 = date.next()
  date2 = date1.next()
  date3 = date2.next()
  date4 = date3.next()
  date5 = date4.next()
  c.addEvent(date2, e1)
  c.addEvent(date2, e2)
  c.addEvent(date3, e3)
  c.addEvent(date3, e4)

  it 'returns Event added successfully message if event is added' do
    e = Events.new("Mothers Day event")
    

    expect(c.addEvent(date, e)).to eq "Event added successfully!" 
  end

  it 'returns Event deleted successfully message if event is deleted' do
    details = "Mothers Day event"
    date = Date.today

    expect(c.removeEvent(date, details)).to eq "Event deleted successfully!" 
  end

  it 'returns Event edited successfully message if event is edited' do
    old_details = "event1 description"
    new_details = "event1 description edited now!"
    # date = Date.today

    expect(c.editEvent(date2, old_details, new_details)).to eq "Event edited successfully!" 
  end

  it 'returns success message if all events of given date are printed' do
    

    expect(c.eventDetails(Date.parse("2017-7-5"))).to eq "All events of given date are printed successfully!" 
  end


  it 'returns success message if all events of given month are printed' do
    

    expect(c.allMonthEventsDetails("07", "2019")).to eq "All events of given month are printed successfully!" 
  end
end
