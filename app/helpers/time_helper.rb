module TimeHelper
  def get_booking_avaible_minutes(mindate)
    minute_collection = [00, 10, 20, 30, 40, 50]
    minutes = []
    if mindate.hour >= 11 && mindate.hour <= 21
      minute_collection.each do |m|
        minutes << m if m > (mindate + 30.minutes).minute
      end
      if mindate.minute >= 20 && mindate.minute < 30
        minutes = minute_collection
      end
    else
      minutes = minutes = minute_collection
    end
    minutes
  end

  def get_min_hour(mindate)
    minhour = if mindate.hour >= 11
                if mindate.minute >= 20
                  mindate.hour + 1
                else
                  mindate.hour
                end
              else
                11
              end
    minhour
  end
  def get_order_min_hour(mindate)
    minhour = mindate.hour > 11 ? mindate.hour + 1 : 11
    minhour += 1 if mindate.minute > 50
    minhour
  end

  def get_order_avaible_minutes(minhour)
    bash = [00, 10, 20, 30, 40, 50]
    minutes = []
    if minhour < DateTime.now.hour + 2
      bash.each do |m|
        minutes << m if m >= @mindate.minute
      end
    else
      minutes = bash
    end
    minutes
  end
end