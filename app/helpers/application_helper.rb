module ApplicationHelper
  def convert_seconds_to_time(seconds)
   total_minutes = seconds / 1.minutes
   seconds_in_last_minute = seconds - total_minutes.minutes.seconds
   "#{total_minutes}m #{seconds_in_last_minute}s"
  end

  def time_till_next
    Time.at((Package.order(:start_time).first.start_time - Time.now).round()).strftime("%H:%M:%S")
  end
end
