require './lib/calendar'
require 'date'

describe 'Calendar' do
  c = Calendar.new
  e1 = Events.new('event1 description')
  e2 = Events.new('event2 description')
  e3 = Events.new('event3 description')
  e4 = Events.new('event4 description')
  date = Date.today
  date1 = date.next
  date2 = date1.next
  date3 = date2.next
  c.add_event(date2, e1)
  c.add_event(date2, e2)
  c.add_event(date3, e3)
  c.add_event(date3, e4)

  it 'returns Event added successfully message if event is added' do
    e = Events.new('Mothers Day event')
    expect(c.add_event(date, e)).to eq 'Event added successfully!' 
  end

  it 'returns Event deleted successfully message if event is deleted' do
    details = 'Mothers Day event'
    date = Date.today

    expect(c.remove_event(date, details)).to eq 'Event deleted successfully!'
  end

  it 'returns Event edited successfully message if event is edited' do
    old_details = 'event1 description'
    new_details = 'event1 description edited now!'
    # date = Date.today

    expect(c.edit_event(date2, old_details, new_details)).to eq 'Event edited successfully!'
  end

  it 'returns success message if all events of given date are printed' do
    expect(c.event_details(Date.parse("2017-7-5"))).to eq 'All events of given date are printed successfully!'
  end


  it 'returns success message if all events of given month are printed' do
    expect(c.all_month_events_details("07", "2019")).to eq 'All events of given month are printed successfully!' 
  end
end
