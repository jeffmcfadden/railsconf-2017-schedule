require 'nokogiri'
require 'open-uri'
require 'yaml'

doc = Nokogiri::HTML(open( 'http://railsconf.com/schedule') )

events = []

['#tuesday', '#wednesday', '#thursday'].each_with_index do |day, i|

  start_time = Date.parse( "2017-04-25" ).to_time + (i * 86400)
  end_time   = Date.parse( "2017-04-25" ).to_time + (i * 86400)
  
  doc.css( "#{day} .rc-schedule-talk" ).each do |talk|
    track = talk.css( '.rc-schedule-talk__track' ).text.strip
    title = talk.css( '.rc-schedule-talk__title' ).text.strip
    speaker = talk.css( '.rc-schedule-talk__speaker' ).text.strip
    room = talk.css( '.rc-schedule-talk__room' ).text.strip
    
    events.push( { title: title, track: track, speaker: speaker, room: room, start_time: start_time, end_time: end_time } )
  end
end

events

puts events.to_yaml