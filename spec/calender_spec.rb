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

  it 'returns true if event is added' do
    e = Events.new('Mothers Day event')
    expect(c.add_event(date, e)).to eq true
  end

  it 'returns false if same event is added again' do
    e = Events.new('Mothers Day event')
    expect(c.add_event(date, e)).to eq false
  end

  it 'returns true if event is deleted' do
    details = 'Mothers Day event'
    date = Date.today

    expect(c.remove_event(date, details)).to eq true
  end

  it 'returns false if non existing event is given to delete' do
    details = 'I am a non existing event'
    date = Date.today

    expect(c.remove_event(date, details)).to eq false
  end

  it 'returns true if event is edited' do
    old_details = 'event1 description'
    new_details = 'event1 description edited now!'
    expect(c.edit_event(date2, old_details, new_details)).to eq true
  end

  it 'returns false if non existing event is given to edit' do
    old_details = 'I am a non existing event'
    new_details = 'event1 description edited now!'
    expect(c.edit_event(date2, old_details, new_details)).to eq false
  end
end
