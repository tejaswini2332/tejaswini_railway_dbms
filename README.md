### Load database into mysql

 ``` shell

mysql -u <username> -p <password>
```

``` mysql
source ./rail.sql;
```

### Run python script

   - Required libraries:   tabulate, subprocess (built-in), PyMySQL
  
``` shell
    pip install tabulate
```

``` shell
    python3 -m pip install PyMySQL
```

  - Run script
  
``` shell
    python3 rail.py
```

Provide username and password for mysql when prompted. Port = 3306 and localhost have been assumed.

## Modifications Made

- Coach_type has been changed to include the following types: First AC, Second AC, Third AC, Chair Car, Sleeper
- Seat_type has been changed to include the following types: EC, 1A, 2A, 3A, FC, CC, SL, 2S
- Passenger ID has been changed to 5 digit instead of 12
- Ticket ID has been changed to 6 digit instead of 9
- Passengers are categorized as Student or Military instead of Children and Elderly
- Constraints on number of seats per coach has been changed to 20-90.
- From_location and To_location attributes of Ticket and the corresponding relation in 3NF have been removed due to redundant information.
- Employee ID has been changed to 6 digit instead of 12 digit

## Functions Supported

1. `hireEmp`: Insertion of Employee Record
2. `inPassenger`: Insertion of Passenger Record
3. `bookTkt`: Insertion of Ticket Entity
4. `cancelTkt`: Delete Ticket
5. `fireEmp`: Delete Employee Record
6. `upPas`: Update Birthday and/or Gender of Passenger Record 
7. `upEmp`: Update Supervisor ID and/or Working hours of Employee Record
8. `upTrain`: Update Departure and/or Arrival Time of Train Entry
9. `searchTkt`: Show Ticket details of Family based on Last Name
10. `searchEmpName`: Display Employee Details based on name
11. `searchTrainName`: Search for information (Arrival Station and Timing, Departure Station and Timing, train number) of train having (name)
12. `searchTrainDate`: Show all Trains and information (Arrival Station and Timing, Departure Station and Timing, train number) regarding them that leave on (date)
13. `searchTrainStation`: Show all Trains and information (Arrival Station and Timing, Departure Station and Timing, train number) arriving on (station)
14. `searchEmp`: Show all employees details working on day of the week
15. `tPas`: Name trains having more than 2 passengers
16. `tSeat`: Name trains having more than 50 available seats
17. `crPay`: Name passengers who have paid by credit card
18. `fcSeat`: Display passengers and their details having a first class seat
19. `avgPas`: Calculate avg passengers on train
20. `maxWH`: Display maximum working hours
21. `maxD`: Display maximum discount
22. `totF`: Display Total fares received thus far
23. `maxTK`: Display Maximum ticket price of all tickets booked thus far
24. `minTK`: Display Minimum ticket price of all tickets booked thus far
25. `mPSG`: Display trains having military passengers
26. `fCT`: Display arrival and departure stations having trains with maximum first class ticket bookings
27. `sST`: Display Seat types preferred by student passengers
28. `mavgT`: Display Trains having more than average number of passengers
29. `stP`: Display Payment method preferred by passengers of station