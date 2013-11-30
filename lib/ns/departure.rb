module Ns
  class Departure
    include Ns::Model

    attr_accessor :trip_number, :departure_time, :destination, :train_type,
                  :route, :company, :platform, :travel_tip, :comments,
                  :delay, :delay_text

  end
end
