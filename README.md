# Sweater Weather (wether, sweater?)
  - This API based application consumes 3 external API's and aggregates the data for consumption by a not yet built front end. The final app will allow users to see the current weather as well as the forecasted weather at the destination to aid in road trip planning.


The `external APIs` consumed by this app:

```
http://www.mapquestapi.com/geocoding/v1/address
```
```
https://api.openweathermap.org/data/2.5/onecall
```
```
https://api.unsplash.com/search/photos
```
The api keys can be obtained through each site.  
This app uses the `figaro` gem which has parsed a Git-ignored YAML file in the application and loads its values into ENV.
```
openweather_api_key: <api key here>
mapquest_api_key:    <api key here>
unsplash_api_key:    <api key here>

```

## Endpoints

The following table presents each API endpoint that this app exposes.
- Content-Type: application/json

- Accept: application/json

- All POST requests require an api key which a user obtains through registration

Use | Endpoint
---------|-------------
Get weather info from a location | GET /api/v1/forecast
Returns a background image for a location | GET /api/v1/backgrounds
User registration - generates/ returns an api key | POST /api/v1/users
User log-in - returns an api key | POST /api/v1/sessions
Returns travel time and destination forecast | POST /api/v1/road_trip
