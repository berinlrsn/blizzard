# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Thermostat.create(household_token: 'pypNs7Zxf1onDDDzVmQf', location: 'New York City' )
Thermostat.create(household_token: 'Lw4Pz7DMPQI5i5JT873y', location: 'New York City' )
Thermostat.create(household_token: 'rpvSf9FAaS0cad1PD4M7', location: 'New York City' )
Thermostat.create(household_token: 'FvJvgs7v8COV4sxxzJaw', location: 'New York City' )
Thermostat.create(household_token: 'txAjzjyanWwNqRaiQaDt', location: 'New York City' )
Thermostat.create(household_token: 'XQ5phSVtPkY7ZFz1FX46', location: 'New York City' )
Thermostat.create(household_token: 'g34NKJW9gdhSQkWuZZ7j', location: 'New York City' )
Thermostat.create(household_token: 'jR1NnSq1vg2bovXcQBoP', location: 'New York City' )
Thermostat.create(household_token: 'MQBZIiUOF7KwOOsAzZIu', location: 'New York City' )
Thermostat.create(household_token: 'oYsTrr8OzOKLMkeLu9HF', location: 'New York City' )

thermostat_one = Thermostat.first
thermostat_one.readings.create(temperature: 20, number: 1, humidity: 10, battery_charge: 80.0)
