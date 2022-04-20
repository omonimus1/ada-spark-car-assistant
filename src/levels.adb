package body Levels with SPARK_Mode

is
   procedure TurnEngineOn is begin
      TeslaCar.PowerLevel := On;
   end TurnEngineOn;


   procedure TurnEngineOff is begin
      TeslaCar.PowerLevel :=  Off;
   end TurnEngineOff;

   procedure AddPassenger is begin
      if TeslaCar.NumberOfPassengers >=0 and TeslaCar.NumberOfPassengers <= 5 and TeslaCar.CarSpeed = 0 then
         TeslaCar.NumberOfPassengers := TeslaCar.NumberOfPassengers + 1;
         TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel +1;
      end if;
   end AddPassenger;

   procedure RemovePassenger is begin
      if TeslaCar.NumberOfPassengers >=1 and TeslaCar.NumberOfPassengers <= 5 and TeslaCar.CarSpeed = 0 then
         TeslaCar.NumberOfPassengers := TeslaCar.NumberOfPassengers -1 ;
         TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel -1;
      end if;
   end RemovePassenger;


   procedure EnableDiagosticMode is begin
      TeslaCar.MaintenanceMode := On;
   end EnableDiagosticMode;

   procedure DisableDiagosticMode is begin
      TeslaCar.MaintenanceMode := Off;
   end DisableDiagosticMode;

   procedure IncreaseSpeed is begin
      if (TeslaCar.CarSpeed < 30) then
         TeslaCar.CarSpeed := TeslaCar.CarSpeed +5;
         TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel + 1;
         TeslaCar.GearInserted := TeslaCar.GearInserted + 1;
      end if;
   end IncreaseSpeed;


   procedure DecreaseSpeed is begin
      TeslaCar.CarSpeed := TeslaCar.CarSpeed -5;
      TeslaCar.GearInserted := TeslaCar.GearInserted -1;
      TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel -1;
   end DecreaseSpeed;


   procedure Turn is
   begin
       TeslaCar.CarSpeed := TeslaCar.CarSpeed +5;
       TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel + 1;
       TeslaCar.GearInserted := TeslaCar.GearInserted + 1;
   end Turn;


end Levels;
