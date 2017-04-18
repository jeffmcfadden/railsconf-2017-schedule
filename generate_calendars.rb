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
  end
end

File.open( 'calendars/RC2017_all_events.ics', 'w') {|f| f.write(cal.to_ical) }

events.group_by{ |e| e[:track] }.each do |track_name, events|
  cal = Icalendar::Calendar.new
  tzid = "America/Phoenix"
  
  events.each do |event|
    cal.event do |e|
      e.dtstart = Icalendar::Values::DateTime.new event[:start_time], 'tzid' => tzid
      e.dtend   = Icalendar::Values::DateTime.new event[:end_time], 'tzid' => tzid
      e.summary = "#{event[:title]} (#{event[:track]})"
      e.location = event[:room]
      e.description = event[:description]
    end
  end
  
  File.open( "calendars/RC2017_#{track_name.gsub( ' ', '_' ).downcase}.ics", 'w') {|f| f.write(cal.to_ical) }
end