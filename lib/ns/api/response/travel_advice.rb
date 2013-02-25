module Ns
  module Api
    module Response
      class TravelAdvice
        include Ns::Model

        attr_accessor :parsed_response

        def travel_options
          raw_travel_options.map do |travel_option|
            Ns::TravelOption.new(
              planned_departure: travel_option['GeplandeVertrekTijd'],
              actual_departure:  travel_option['ActueleVertrekTijd'],
              planned_arrival:   travel_option['GeplandeAankomstTijd'],
              actual_arrival:    travel_option['ActueleAankomstTijd'],
              changes:           travel_option['AantalOverstappen'],
              platform:          platform(travel_option),
              optimal:           travel_option['Optimaal']
            )
          end
        end

        private

        def raw_travel_options
          if parsed_response.has_key?('ReisMogelijkheden') && parsed_response['ReisMogelijkheden'].has_key?('ReisMogelijkheid')
            parsed_response['ReisMogelijkheden']['ReisMogelijkheid']
          else
            []
          end
        end

        def platform(travel_option)
          travel_part = travel_option['ReisDeel']

          if travel_part.is_a?(Array)
            travel_part.first['ReisStop'].first['Spoor']
          else
            travel_part['ReisStop'].first['Spoor']
          end
        end

      end
    end
  end
end
