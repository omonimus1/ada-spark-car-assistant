package body borst with SPARK_Mode
is

   procedure AddRod is
   begin
      if BorstMobile.Generator.Powered = On and BorstMobile.Generator.Rods < ControlRod'Last then
         BorstMobile.Generator.Rods := BorstMobile.Generator.Rods + 1;
         BorstMobile.Generator.Maintenance := BorstMobile.Generator.Maintenance + 1;
         BorstMobile.Generator.Heat := GetHeat(BorstMobile.Generator.WaterTank, BorstMobile.Generator.Rods);
         BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
         BorstMobile.CurSpeed := GetCurrentSpeed(BorstMobile.Cart.Weight,BorstMobile.Generator.Heat);
      end if;
   end AddRod;

   procedure RemoveRod is
   begin
      if BorstMobile.Generator.Powered = On and BorstMobile.Generator.Rods > ControlRod'First then
         BorstMobile.Generator.Rods := BorstMobile.Generator.Rods - 1;
         BorstMobile.Generator.Maintenance := BorstMobile.Generator.Maintenance + 1;
         BorstMobile.Generator.Heat := GetHeat(BorstMobile.Generator.WaterTank, BorstMobile.Generator.Rods);
         BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
         BorstMobile.CurSpeed := GetCurrentSpeed(BorstMobile.Cart.Weight,BorstMobile.Generator.Heat);
     end if;
   end RemoveRod;

   procedure DoMaintenance is
   begin
      if(BorstMobile.Generator.Powered = Off and BorstMobile.Generator.Rods = ControlRod'Last and BorstMobile.CurSpeed = Speed'First) then
         BorstMobile.Generator.WaterTank := Level'Last;
         BorstMobile.Generator.Maintenance := LastMaintained'First;
         BorstMobile.Generator.MtnLight := GREEN;
         BorstMobile.Generator.WaterLight := GREEN;
         BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
      end if;

   end DoMaintenance;


   --Can only start the engine if it isnt already Powered, the Water Tank
   --is more than half full
   procedure StartEngine is
   begin
      BorstMobile.Generator.Powered := On;
      BorstMobile.Generator.HeatLight := GREEN;
      BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
      BorstMobile.Cart.MaxSpeed := GetMax(BorstMobile.Cart.Cars);
   end StartEngine;

   --Turns everything off, does not remove cars or fill water tank
   procedure StopEngine is
   begin
      BorstMobile.Generator.Powered := Off;
      BorstMobile.Generator.Rods := ControlRod'Last;
      BorstMobile.CurSpeed := Speed'First;
      BorstMobile.Generator.Heat := EngineTemp'First;
   end StopEngine;

   procedure AddTrainCar is
   begin
      BorstMobile.Cart.Cars := BorstMobile.Cart.Cars + 1;
      BorstMobile.Cart.MaxSpeed := GetMax(BorstMobile.Cart.Cars);
      BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
   end AddTrainCar;

   procedure RemoveTrainCar is
   begin
      BorstMobile.Cart.Cars := BorstMobile.Cart.Cars - 1;
      BorstMobile.Cart.MaxSpeed := GetMax(BorstMobile.Cart.Cars);
      BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
   end RemoveTrainCar;

   function GetMax (num          : NumCarriages) return Speed is
   begin
      --Each Carriage reduces the maximum speed limit of the BorstMobile by 10km/h
      return Speed(200 - (Integer(num)*10));
   end GetMax;

   function GetHeat (water       : Level; rods : ControlRod) return EngineTemp is
      heat                       : EngineTemp;
   begin
      heat := EngineTemp((Integer(Level'Last)-Integer(water)+1)*(Integer(ControlRod'Last)-Integer(rods))*55);
      return heat;
   end GetHeat;

   function GetCurrentSpeed (car : Mass; heat : EngineTemp) return Speed is
   begin
      return Speed((Integer(Integer(heat) * Integer(Speed'Last))/Integer(EngineTemp'Last)) * (1-(Integer(car)/(Integer(Mass'Last)*2))));
   end GetCurrentSpeed;

   procedure EmergencyStop is
   begin
      if BorstMobile.Generator.Heat >= 2200 then
         BorstMobile.Generator.Powered := Off;
         BorstMobile.Generator.HeatLight := RED;
         BorstMobile.Generator.Rods := ControlRod'Last;
         BorstMobile.CurSpeed := Speed'First;
         BorstMobile.Generator.Heat := EngineTemp'First;
      end if;
   end EmergencyStop;

   procedure FillTank is
   begin
      if BorstMobile.CurSpeed = Speed'First then
         BorstMobile.Generator.WaterTank := Level'Last;
         BorstMobile.Generator.WaterLight := GREEN;
         BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
      end if;
   end FillTank;

   procedure HeatL is
   begin

      if (BorstMobile.Generator.Heat < 2200 and BorstMobile.Generator.Heat > 1700) then
            BorstMobile.Generator.HeatLight := AMBER;
      else
         BorstMobile.Generator.HeatLight := GREEN;
      end if;
   end HeatL;


   procedure TankL is
   begin
      BorstMobile.Generator.WaterTank := BorstMobile.Generator.Watertank - 1;
      BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
      BorstMobile.Generator.Heat := GetHeat(BorstMobile.Generator.WaterTank, BorstMobile.Generator.Rods);
      BorstMobile.CurSpeed := GetCurrentSpeed(BorstMobile.Cart.Weight,BorstMobile.Generator.Heat);
      if (BorstMobile.Generator.WaterTank > 4 and BorstMobile.Generator.WaterTank < 7) then
         BorstMobile.Generator.WaterLight := AMBER;
      else if (BorstMobile.Generator.WaterTank<=4) then
            BorstMobile.Generator.WaterLight := RED;
         end if;
      end if;

   end TankL;

   procedure MaintL is
   begin
      if BorstMobile.Generator.Powered = On then
         BorstMobile.Generator.Maintenance := BorstMobile.Generator.Maintenance + 1;
         if ((BorstMobile.Generator.Maintenance>((4/10)*(LastMaintained'Last))) and (BorstMobile.Generator.Maintenance<((7/10)*(LastMaintained'Last)))) then
            BorstMobile.Generator.MtnLight := AMBER;
         else if (BorstMobile.Generator.Maintenance>=((7/10)*(LastMaintained'Last))) then
               BorstMobile.Generator.MtnLight := RED;
               if BorstMobile.Generator.Maintenance = LastMaintained'Last then
                  BorstMobile.Generator.Powered := Off;
                  BorstMobile.Generator.Rods := ControlRod'Last;
                  BorstMobile.CurSpeed := Speed'First;
                  BorstMobile.Generator.Heat := EngineTemp'First;
               end if;
            end if;
         end if;
      end if;
   end MaintL;

   procedure SpeedL is
   begin
      if BorstMobile.Generator.Powered = On then
         if BorstMobile.CurSpeed > BorstMobile.Cart.MaxSpeed then
            if BorstMobile.Generator.Rods < ControlRod'Last then
               AddRod;
            else
               BorstMobile.Generator.Rods := ControlRod'Last;
               BorstMobile.CurSpeed := Speed'First;
               BorstMobile.Generator.Heat := EngineTemp'First;
            end if;
         end if;
      end if;

   end SpeedL;

   procedure ChangeCarriageType is
   begin
      if BorstMobile.Cart.Cars = NumCarriages'First then
         case BorstMobile.TrainType is
         when FREIGHT => BorstMobile.TrainType := PASSENGER;
            BorstMobile.Cart := (Typtr=>PASSENGER,
                                 Cars=>NumCarriages'First,
                                 MaxSpeed=>BorstMobile.Cart.MaxSpeed,
                                 Weight=>BorstMobile.Cart.Weight,
                                 Voyagers=>PassengerCount'First);
         when PASSENGER=> BorstMobile.TrainType := FREIGHT;
            BorstMobile.Cart := (Typtr=>FREIGHT,
                                 Cars=>NumCarriages'First,
                                 MaxSpeed=>BorstMobile.Cart.MaxSpeed,
                                 Weight=>BorstMobile.Cart.Weight,
                                 Cargo=>FreightWeight'First);
         end case;
      end if;
   end ChangeCarriageType;

   procedure AddPassenger is
   begin
      if BorstMobile.Cart.Cars > NumCarriages'First then
            BorstMobile.Cart.Voyagers := BorstMobile.Cart.Voyagers+1;
            BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
      end if;
   end AddPassenger;

   procedure RemovePassenger is
   begin
      if BorstMobile.Cart.Voyagers > PassengerCount'First then
         BorstMobile.Cart.Voyagers := BorstMobile.Cart.Voyagers-1;
         BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
      end if;
   end RemovePassenger;

   procedure AddFreight is
   begin
      if BorstMobile.Cart.Cars > NumCarriages'First then
         if (Integer(BorstMobile.Cart.Cargo) < (Integer(FreightWeight'Last) * (Integer(BorstMobile.Cart.Cars)/Integer(NumCarriages'Last)))) then
            BorstMobile.Cart.Cargo := BorstMobile.Cart.Cargo+1;
            BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
         end if;
      end if;
   end AddFreight;

   procedure RemoveFreight is
   begin
      if BorstMobile.Cart.Cargo > FreightWeight'First then
         BorstMobile.Cart.Cargo := BorstMobile.Cart.Cargo-1;
         BorstMobile.Cart.Weight := CalcWeight(BorstMobile.Generator.Watertank, BorstMobile.Cart);
      end if;
   end RemoveFreight;

   function CalcWeight (wat : Level; car : Carriage) return Mass is
      Total : Mass;
   begin
      if car.Typtr = FREIGHT then
         Total := Mass(Integer(Mass'First) + Integer(wat) + (Integer(car.Cars) * 40) + Integer(car.Cargo));
      else
         Total := Mass(Integer(Mass'First) + Integer(wat) + (Integer(car.Cars) * 60) + Integer(car.Voyagers * (70/1000)));
      end if;

      return Total;

   end CalcWeight;

end borst;
