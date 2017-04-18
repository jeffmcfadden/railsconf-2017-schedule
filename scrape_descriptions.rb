require 'nokogiri'
require 'open-uri'
require 'yaml'

events = YAML.load_file( 'events.yml' )

doc = Nokogiri::HTML(open( 'http://railsconf.com/program') )


doc.css( '.session' ).each do |session|
  title = session.css( 'h1' ).text.strip
  desc  = session.css( '.markdown-content' ).text.strip
  about_speaker = session.css( '.session__speaker' ).text.strip
  
  event = events.select{ |e| e[:title].downcase.strip == title.downcase.strip }.first
  
  if event.nil?
    puts "Couldn't find event with title #{title}"
  else
    event[:description] = "#{desc}\n\n#{about_speaker}"
  end
end

Couldn't find event with title âRecurring Background Jobs with Sidekiq-scheduler
Couldn't find event with title Whatâs my app *really* doing in production?
Couldn't find event with title âRails APIs: The Next Generation
Couldn't find event with title âKeeping Code Style Sanity in a 10-year-old Codebase
Couldn't find event with title âIntroducing Helix: High-Performance Ruby Made Easy
Couldn't find event with title Understanding âSpoon Theoryâ and Preventing Burnout
Couldn't find event with title Rack âem, Stack âem Web Apps
Couldn't find event with title Tailoring Mentorship: Achieving the Best Fitâ¨
Couldn't find event with title Your App Server Config is Wrongâ¨
Couldn't find event with title âPostgres at Any Scaleâ
