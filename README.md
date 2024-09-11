# README

Aplication for bike courier to control work (rides during delivery of packages).
No login required. Only API endpionts as shown below.

API allows to:
- create trip objects in data base: POST http://localhost:3000/trips + params: start_address, destination_address, price, date, distance
- listing all saved trips: GET http://localhost:3000/trips
- show specific trip by id: GET http://localhost:3000/trips/:id
- destroy trip object by id: DELETE http://localhost:3000/trips/:id
- control statistics of courier rides (trips): GET http://localhost:3000/stats/weekly | GET http://localhost:3000/stats/monthly

App created with: Ruby, RoR, Postgresql. Distance calculations between start and destination addresses made with 'geocoder'.
