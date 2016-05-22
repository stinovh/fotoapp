module ApplicationHelper
  def convert_seconds_to_time(seconds)
   total_minutes = seconds / 1.minutes
   seconds_in_last_minute = seconds - total_minutes.minutes.seconds
   "#{total_minutes}m #{seconds_in_last_minute}s"
  end

  def time_till_next
    seconds =(Package.order(:start_time).first.start_time - Time.now).round()
    return "Coming Soon" if seconds.to_s.include? "-"
    time_array = seconds_to_dhms(seconds)
    return "#{time_array[0]}d #{time_array[1]}h #{time_array[2]}m #{time_array[3]}s"
  end

  def seconds_to_dhms(seconds)
    [60,60,24].map{ |dm| seconds,t = seconds.divmod(dm); t }.reverse.unshift seconds
  end
end
