module Ns
  module Api
    module Response
      class DepartureCollection
        include Ns::Model

        attr_accessor :parsed_response

        def departures
          ( raw_departures['VertrekkendeTrein'] || [] ).map do |raw_departure|
            new_departure(raw_departure)
          end.flatten.compact
        end

        private

        def new_departure(raw_departure)
          Ns::Departure.new(
            trip_number:      raw_departure['RitNummer'],
            departure_time:   raw_departure['VertrekTijd'],
            destination:      raw_departure['EindBestemming'],
            train_type:       raw_departure['TreinSoort'],
            route:            raw_departure['RouteTekst'],
            company:          raw_departure['Vervoerder'],
            platform:         raw_departure['VertrekSpoor'],
            travel_tip:       raw_departure['ReisTip'],
            comments:         raw_departure['Opmerkingen'] || []
          )
        end

        def raw_departures
          if parsed_response.has_key?('ActueleVertrekTijden')
            parsed_response['ActueleVertrekTijden']
          else
            {}
          end
        end

      end
    end
  end
end
