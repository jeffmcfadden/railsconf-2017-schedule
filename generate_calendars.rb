require 'yaml'
require 'icalendar'

events = YAML.load_file( 'events.yml' )

cal = Icalendar::Calendar.new
tzid = "America/Phoenix"

events.each do |event|
  cal.event do |e|
    e.dtstart = Icalendar::Values::DateTime.new event[:start_time], 'tzid' => tzid
    e.dtend   = Icalendar::Values::DateTime.new event[:end_time], 'tzid' => tzid
    e.summary = "#{event[:title]} (#{event[:track]})"
    e.location = event[:room]
    e.description = event[:description]
    # e.description = "Have a long lunch meeting and decide nothing..."
    # e.organizer = "mailto:jsmith@example.com"
    # e.organizer = Icalendar::Values::CalAddress.new("mailto:jsmith@example.com", cn: 'John Smith')
  end
end

puts cal.to_ical