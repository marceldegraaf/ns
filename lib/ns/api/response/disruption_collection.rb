module Ns
  module Api
    module Response
      class DisruptionCollection

        attr_reader :parsed_response

        def initialize(parsed_response)
          @parsed_response = parsed_response
        end

        def planned_disruptions
          ( raw_disruptions['Gepland'] || [] ).map do |raw_disruption|
            new_disruption(raw_disruption)
          end.flatten.compact
        end

        def unplanned_disruptions
          ( raw_disruptions['Ongepland'] || [] ).map do |raw_disruption|
            new_disruption(raw_disruption)
          end.flatten.compact
        end

        private

        def raw_disruptions
          if parsed_response.has_key?('Storingen') && ( parsed_response['Storingen'].has_key?('Gepland') || parsed_response['Storingen'].has_key?('Ongepland') )
            parsed_response['Storingen']
          else
            {}
          end
        end

        #
        # Each disruption looks like this:
        #
        # [ 'Storing', { id: '12345', 'Traject': ... } ]
        #
        # which is why we do a check for size, shift the array, and return
        # the first element in the array which is the actual disruption
        # Hash
        #
        def new_disruption(raw_disruption)
          if raw_disruption.size >= 2
            raw_disruption = raw_disruption[1]

            Ns::Disruption.new(
              route:   raw_disruption['Traject'],
              reason:  raw_disruption['Reason'],
              message: raw_disruption['Bericht'],
              advice:  raw_disruption['Advies'],
              period:  raw_disruption['Periode']
            )
          end
        end

      end
    end
  end
end
