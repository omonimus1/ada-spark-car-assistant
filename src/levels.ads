package Levels with SPARK_Mode
is
   type Power is (On, Off);
   type Battery is range 0..100;
   type BatteryDegradation is range 0..100;
   type Speed is range 0..100;
   type Maintenance is (On, Off);
   type Passengers is range 0..5;
   type Gear is range -1..5;
   type MaxSpeed is range 30..30;
   type Object is (On, Off);

   type Car is record
      PowerLevel: Power;
      BatteryLevel: Battery;
      BatteryDegradationLevel: BatteryDegradation;
      CarSpeed: Speed;
      GearInserted: Gear;
      MaintenanceMode: Maintenance;
      NumberOfPassengers: Passengers;
      ObjectDetected: Object;
   end record;

   type RoadRule is record
      SpeedLimit: MaxSpeed;
   end record;
   Str : String(1..2);

   RoadLimitation : RoadRule := (
                                 SpeedLimit=> 30);

   TeslaCar : Car := (PowerLevel=> Off,
                      BatteryLevel=>0,
                      BatteryDegradationLevel=>0,
                      CarSpeed=>0,
                      GearInserted=>0,
                      MaintenanceMode=> Off,
                      ObjectDetected=>Off,
                      NumberOfPassengers=> 0);

   procedure TurnEngineOn with
     Global => (In_Out => TeslaCar),
     Pre => (TeslaCar.PowerLevel = Off),
     Post => TeslaCar.PowerLevel = On;

   procedure TurnEngineOff with
     Global => (In_Out => TeslaCar),
     Pre => (TeslaCar.PowerLevel = On),
     Post => TeslaCar.PowerLevel = Off;

   procedure AddPassenger with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.NumberOfPassengers >= 0 and TeslaCar.NumberOfPassengers <= 5 and TeslaCar.CarSpeed = 0,
     Post => TeslaCar.NumberOfPassengers >=0 and TeslaCar.NumberOfPassengers <=5;

   procedure RemovePassenger with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.NumberOfPassengers >= 1 and TeslaCar.NumberOfPassengers <= 5 and TeslaCar.CarSpeed = 0,
     Post => TeslaCar.NumberOfPassengers >=1 and TeslaCar.NumberOfPassengers <=5;

   procedure EnableDiagosticMode with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.MaintenanceMode = Off,
     Post => TeslaCar.MaintenanceMode = On;

   procedure DisableDiagosticMode with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.MaintenanceMode = On,
     Post => TeslaCar.MaintenanceMode = Off;

   function InvariantSpeedLimit return Boolean is
      (TeslaCar.CarSpeed < 30);


   function InvariantAcceleration return Boolean is
     (TeslaCar.NumberOfPassengers >=1 and then TeslaCar.PowerLevel = On
      and then TeslaCar.BatteryLevel > 0 and then TeslaCar.MaintenanceMode = Off);

   procedure IncreaseSpeed with
     Global => (In_Out => TeslaCar),
     Pre => InvariantAcceleration and then InvariantSpeedLimit,
     Post => InvariantAcceleration and then InvariantSpeedLimit;

   function InvariantDeceleration return Boolean is
      (TeslaCar.MaintenanceMode = Off);

   procedure DecreaseSpeed with
     Global => (In_Out => TeslaCar),
     Pre => InvariantDeceleration,
     Post => InvariantDeceleration;

   procedure Turn with
     Global => (In_Out => TeslaCar),
     Pre=> TeslaCar.PowerLevel = On and then TeslaCar.BatteryLevel > 0 and then TeslaCar.GearInserted >=1
     and then TeslaCar.NumberOfPassengers >=1 and then TeslaCar.ObjectDetected = Off and then TeslaCar.MaintenanceMode = Off,
     Post => TeslaCar.PowerLevel = On and then TeslaCar.BatteryLevel > 0 and then TeslaCar.GearInserted >=1
     and then TeslaCar.NumberOfPassengers >=1 and then TeslaCar.ObjectDetected = Off and then TeslaCar.MaintenanceMode = Off;



end Levels;
