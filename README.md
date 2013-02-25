Ruby implementation of the NS API
=================================

Ruby implementation of the NS (Dutch Railways) API

## Request an API username and password from NS

Before using this gem you should request a username and password from the
NS API pages. This allows you to authenticate your API requests and will
make sure you get actual data back.

Head over to http://www.ns.nl/api/api to request your credentials.

## Configuring the gem

To configure the gem, place an <tt>Ns.configure</tt> block in your code:

```
Ns.configure do |config|
  config.username = 'john@doe.com'
  config.password = 'your-secret-password'
end
```

## Using the gem

Currently the gem implements the following API calls:

- Requesting a travel advice from one station to another

Each of these calls is explained below.

### Requesting a travel advice

To request a travel advice you need at least the names of the departure and
the arrival station. You may use the full string name of the station, e.g.
"Utrecht Centraal" or the abbreviated station code, e.g. "ut".

Requesting travel advice is done by creating a new <tt>Ns::Trip</tt>. A
trip has a <tt>travel_options</tt> method that returns a collection of
<tt>Ns::TravelOption</tt> objects. See the code for the methods these objects
expose.

```
trip = Ns::Trip.new(from: 'Amsterdam Centraal', to: 'Ede Centrum')
trip.travel_options # <= returns Ns::TravelOption objects
```

Optionally you may supply a desired departure or arrival time to the trip:

```
trip = Ns::Trip.new(from: 'Amsterdam Centraal', to: 'Ede Centrum', arrival: Time.now)
trip_2 = Ns::Trip.new(from: 'Amsterdam Centraal', to: 'Ede Centrum', departure: Time.now)
```

You may also specify a <tt>via</tt> station:

```
trip = Ns::Trip.new(from: 'Amsterdam Centraal', to: 'Ede Centrum', via: 'Utrecht Centraal', arrival: Time.now)
```

The returned <tt>Ns::TravelOption</tt> objects have a <tt>optimal</tt> attribute that tells you wether or not the
travel option is regarded as the optimal option for your trip by the NS.

**Note**: the times returned by an instance of <tt>Ns::TravelOption</tt> (e.g.
trip durations, delays) are all in seconds.

### Requesting a list of interruptions

Requesting disruptions requires a station. Disruptions that affect the given station will be returned:

```
disruption_collection = Ns::DisruptionCollection.new(station: 'Amsterdam Centraal')
```

An instance of <tt>Ns::DisruptionCollection</tt> has a <tt>planned_disruptions</tt> method and a <tt>unplanned_disruptions</tt>
method. The results of these methods are <tt>Ns::Disruption</tt> objects.

## Development

Pull requests are welcome! To add your feature: create a fork, implement the
feature on a topic branch, add specs and create a pull request here on Github.
