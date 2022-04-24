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

The car'assistance controller is developed into three core files:
* levels.ads
* levels.adb
* main.adb

The main.adb file contains the contact point between the business logic of the prototype and the final user. 
The main file is the core file that gets runned when the ada spark project is build and executed. Within this file it has been implemented a 
body task that gets executed when the project is build. Within the body task it has been implement a loop used for the management and testing of the car driving assistance.

At each iteration, the program checks if the engine is on and currnet number of passengers. In according to the graduation level, if the engine is running, the battery charge decreases.

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




