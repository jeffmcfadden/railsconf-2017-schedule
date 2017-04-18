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

doc = Nokogiri::HTML(open( 'http://railsconf.com/program/workshops') )

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

puts events.select{ |e| e[:description].to_s.strip == "" }.collect{ |e| e[:title] }.join( "\n" )


File.open( "events.yml", 'w') {|f| f.write(events.to_yaml) }

# Making Moves With React
# Refactoring for Machine Dignity
# Tailoring Mentorship: Achieving the Best Fit
# Postgres at Any Scale
# Elm For Rails Developers
# TDD: From feature to tests to implementation
# Introducing Helix: High-Performance Ruby Made Easy
# Your App Server Config is Wrong
# 
# Make your life easier with shell scripting and UNIX tools
# Demystifying interface design
# Rails APIs: The Next Generation
# Love Your Database
# Structuring your application flow with command chains
# Recurring Background Jobs with Sidekiq-scheduler
# Keeping Code Style Sanity in a 10-year-old Codebase
# What's my app *really* doing in production?
