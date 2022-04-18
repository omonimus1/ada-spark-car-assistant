with borst; use borst;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   Str : String(1..2);
   Last : Natural;
   task Start;
   task Tank;
   task Safety is
      pragma Priority(10);
   end Safety;


   task body Start is
   begin
      Put_Line("BorstMobile Generator State: ");
      Put_Line(BorstMobile.Generator.Powered'Image);
      loop
         Put_Line("Please enter what you would like to do:");
         Get_Line(Str,Last);
         case Str(1) is
         when '1' => StartEngine;
            Put_Line("BorstMobile Generator: ");
            Put_Line(BorstMobile.Generator.Powered'Image);
         when '2' => StopEngine;
            Put_Line("BorstMobile Generator: ");
            Put_Line(BorstMobile.Generator.Powered'Image);
         when '3' => RemoveRod;
            Put_Line("Control Rods: ");
            Put_Line(BorstMobile.Generator.Rods'Image);
            Put_Line("BorstMobile Heat: ");
            Put_Line(BorstMobile.Generator.HeatLight'Image);
            Put_Line("BorstMobile Current Speed: ");
            Put_Line(BorstMobile.CurSpeed'Image);
         when '4' => AddRod;
            Put_Line("Control Rods: ");
            Put_Line(BorstMobile.Generator.Rods'Image);
            Put_Line("BorstMobile Heat: ");
            Put_Line(BorstMobile.Generator.HeatLight'Image);
            Put_Line("BorstMobile Current Speed: ");
            Put_Line(BorstMobile.CurSpeed'Image);
         when '5' => AddTrainCar;
            Put_Line("TrainType: ");
            Put_Line(BorstMobile.TrainType'Image);
            Put_Line("Number Of Carriages: ");
            Put_Line(BorstMobile.Cart.Cars'Image);
         when '6' => RemoveTrainCar;
            Put_Line("TrainType: ");
            Put_Line(BorstMobile.TrainType'Image);
            Put_Line("Number Of Carriages: ");
            Put_Line(BorstMobile.Cart.Cars'Image);
            case BorstMobile.TrainType is
               when FREIGHT =>
                  Put_Line("Tonnes of Cargo: ");
                  Put_Line(BorstMobile.Cart.Cargo'Image);
               when PASSENGER =>
                  Put_Line("Number of Passengers: ");
                  Put_Line(BorstMobile.Cart.Voyagers'Image);
            end case;
         when '7' => ChangeCarriageType;
            Put_Line("TrainType: ");
            Put_Line(BorstMobile.TrainType'Image);
         when '8' => FillTank;
            Put_Line("Water Level: ");
            Put_Line(BorstMobile.Generator.WaterLight'Image);
         when '9' => DoMaintenance;
            Put_Line("Maintenance: ");
            Put_Line(BorstMobile.Generator.MtnLight'Image);
         when '+' =>
            Put_Line("TrainType: ");
            Put_Line(BorstMobile.TrainType'Image);
            Put_Line("Number Of Carriages: ");
            Put_Line(BorstMobile.Cart.Cars'Image);
            case BorstMobile.TrainType is
               when FREIGHT => AddFreight;
                  Put_Line("Tonnes of Cargo: ");
                  Put_Line(BorstMobile.Cart.Cargo'Image);
               when PASSENGER => AddPassenger;
                  Put_Line("Number of Passengers: ");
                  Put_Line(BorstMobile.Cart.Voyagers'Image);
            end case;
         when '-' =>
            Put_Line("TrainType: ");
            Put_Line(BorstMobile.TrainType'Image);
            Put_Line("Number Of Carriages: ");
            Put_Line(BorstMobile.Cart.Cars'Image);
            case BorstMobile.TrainType is
               when FREIGHT => RemoveFreight;
                  Put_Line("Tonnes of Cargo: ");
                  Put_Line(BorstMobile.Cart.Cargo'Image);
               when PASSENGER => RemovePassenger;
                  Put_Line("Number of Passengers: ");
                  Put_Line(BorstMobile.Cart.Voyagers'Image);
            end case;
         when others => abort Safety; abort Tank; exit;
         end case;
      end loop;
      delay 0.1;
   end Start;

   task body Tank is
   begin
      loop
         TankL;
         MaintL;
         delay 10.0;
      end loop;
   end Tank;

   task body Safety is
   begin
      loop
         SpeedL;
         EmergencyStop;
         delay 0.5;
      end loop;

   end Safety;

begin
   null;
end Main;
