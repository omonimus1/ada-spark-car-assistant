## Report

### Introduction 

In the next paragraph it will be described the design and development of a prototype version of 
a car driver' assistance using ADA Spark. 
The system was developed using the following rules that were provided by the project specification:
1. The car cannot be turned on unless it is in Parked.
2. The car cannot be driven unless there is a minimum charge in the battery.
3. Once in motion, the system will warn of low charge.
4. The speed limit can never be exceeded.
5. The speed of the car must be zero in order to change gear.
6. If the car's sensor detect an object, then the car cannot move towards that object.
7. The car must have a diagostic mode with renderes it incapable of any other operator.


## Controller structure

The car'assistance prototype implemented has been made thinking about a tesla
Car, a car powered by electric powered with higher performances and integrated driver' assistance.

The the following variables has been used to implement the given prototype:
(here add a table of the variables)

Variable Name   - Value Domain  - Description 
PowerLevel        (On, Off)
BatteryLevel      range 0..100
BatteryDegradationlevel range 0..100
CarSpeed            range 0..100
GearInserted         range -1..5
MaintenaceMode        (On, Off)
NumberOfPassengers    range 0..5
ObjectDected          (on, Off)
MinimumBattery        range(0..100)
Parking               (On, Off)
SpeedLimit            range(0..100)


The car'assistance controller is developed into three core files:
* levels.ads
* levels.adb
* main.adb

The main.adb file contains the contact point between the business logic of the prototype and the final user. 
The main file is the core file that gets runned when the ada spark project is build and executed. Within this file it has been implemented a 
body task that gets executed when the project is build. Within the body task it has been implement a loop used for the management and testing of the car driving assistance.

At each iteration, the program checks if the engine is on and currnet number of passengers. In according to the graduation level, if the engine is running, the battery charge decreases.
Also at each iteration, until the user does not click type any non-supported key to stop the application, the system will be in hold, wating for user instructions.




## Description


## Extentiosn 

A part from the minimum project requirements given by the coursework specifications, a second set of requirements has been implemented.
The following set of extensions has been implemented:
1. Menu management
2. Battery degradation level
3. Passengers Management 
4. Car's info system 
5. Charge battery mode. 


#### Menu Management

The access to each interaction with the car a menu has been made available and accessible to each user. The user  will be able to print at any time with the menu, register passenger numbers, which will impact during the car' assistance emulation.
The user will also able at any time to access car's information like:
1. Car speed
2. Number of passenger
3. Battery level
4. Battery degradation level


#### Battery Degradation Level
While the engine is running, there is a minimum of battery degradation level. 
This degradation level may increase or decrease in according to the number of passengers and car speed. 

#### Passengers Management
Is it possible to add or remove passengers inside the car, Just when the car has 
speed 0. As each passenger adds weights inside the car, the battery degration increase, decrease by conseguence the battery charge life-time. 

#### Car's info systen
Allows anytime to provide information related to:
1. Car speed
2. Battery level
3. Battery degradation level
4. Number of passeners
5. Engine status
6. Current Gear inserted
7. Parking mode insered
8. Maintenance status

### Charge battery mode
As the battery charge gets exploitded while driving, is necessary to recharge the Tesla car batteries.
Is possible to recarge the battery when the gear inserted is 0, Engine is off and Car speed is 0. 

----------------------------------------------------------------------


## Description of requirements

### TurnEngineOn (Spark gold)
This procudere allows to turn on the Engine, setting the PowerLevel to On.
The precondition is that PowerLeve is Off, the post-condition, is that PowerLevel is on.

### TurnEngineoff (Spark gold)
This procudere allows to turn of the Engine, setting the PowerLevel to Off, and set the battery degradation metric to zero. 
The precondition is that PowerLeve is On, the post-condition, is that PowerLevel is Off and BatteryDegradationLevel is 0.

###  UnsetParkingMode (Spark gold)
This procudere allows to Unset the parking mode, a car configuration needed to disable the electronic handbranking, and let the driver drive the car. 
The precondition is that Parking is On, Car speed is zero (0), and the gear inserted is 0 (also consiered as neutral).
The post-condition is that Parking is Off, Car speed is zero (0), and the gear inserted is 0 (also consiered as neutral).

###  SetParkingMode (Spark gold)

This procudere allows to set the parking mode, a car configuration needed to enable the electronic handbranking, allowing the car to be safely stationary. 
The precondition is that Parking is Off, Car speed is zero (0), and the gear inserted is 0 (also consiered as neutral).
The post-condition is that Parking is On, Car speed is zero (0), and the gear inserted is 0 (also consiered as neutral).

###  AddPassenger  (Spark gold
This procedure allows to 
The precondition is that
The post-condition is that 


###  RemovePasenger  (Spark gold)
This procedure allows to 
The precondition is that
The post-condition is that 

###  EnableDiagosticMode  (Spark gold)
This procedure allows to 
The precondition is that
The post-condition is that 

###  DisableDiagnosticMode  (Spark gold)

This procedure allows to 
The precondition is that
The post-condition is that 

###  IncreaseSpeed  (Spark gold)
This procedure allows to increase the speed by 5Km/h and increase the battery degradation level as result of an higher speed.
The precondition is that Engine is On, Parking mode is Off, diagostic Mode is Off, and Gear Inserted is at least 1 (>=1), BatteryLevel is >=5 (above the minimum level), and at least the driver is inside the car (having so N. Passenger >=1). 
The post-condition is that Engine is On, Parking mode is Off, diagostic Mode is Off,and Gear Inserted is at least 1 (>=1), BatteryLevel is >=5 (above the minimum level), and at least the driver is inside the car (having so N. Passenger >=1). 


###  DecreaseSpeed  (Spark gold)
This procedure allows to decrease the speed and decrease the battery degradation level as result of a lower speed. The speed will be decreased by 5KM/h.
The precondition is that Engine is On, Parking mode is Off, diagostic Mode is Off
The post-condition is that Engine is On, Parking mode is Off, diagostic Mode is Off.

###  Turn  (Spark gold)
This procedure allows the car to decide if it is safe to turn or not. 
The car cannot turn if one of its sensor will detect an object that may interface with driver and passengers safety. 
If the car is relative slow (under 5), its speed will be increased in order to make a safe and relativly quickly turn. 

The precondition is that the Engine is On, the Gear inserted is at least 1 (>=1), the parking Mode is Off, the DiagosticMode is Off, and that object detection is off. 
The post-condition is that: Engine is On, the Gear inserted is at least 1 (>=1), the parking Mode is Off, the DiagosticMode is Off, and that object detection is off. 









