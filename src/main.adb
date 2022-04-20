with Levels; use Levels;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   Str : String(1..2);
   Last : Natural;
   task Start;


   task body Start is
   begin
      Put_Line("Welcome to your Tesla Management system!");
      loop
         Put_Line("Tesla managemnt menu: ");
         Put_Line("1 - Turn On Engine");
         Put_Line("2 - Turn off Engine");
         Put_Line("3 - Load Passenger");
         Put_Line("4 - Unload Passengers");
         Put_Line("5 - Speed up ");
         Put_Line("6 - Slow Down");
         Put_line("7 - Enable Maintenance Mode");
         Put_Line("8 - Disable Maintenance Mode");
         Put_Line("9 - Turn Right ");
         Put_Line("10- Turn Left");
         Put_Line("Press ANY other key to exit");

         Put_Line("Please enter what you would like to do:");
         Get_Line(Str,Last);
         case Str(1) is
         when '1' =>
            Put_Line("Turning on Car...");
            TurnEngineOn;
            Put_Line("Engine status:");
            Put_Line(TeslaCar.PowerLevel'Image);
         when '2' =>
            Put_Line("Turning Car off...");
            TurnEngineOff;
            Put_Line("Engine Status:");
            Put_Line(TeslaCar.PowerLevel'Image);
         when '3' =>
            Put_Line("Check passenger availability...");
            AddPassenger;
            Put_Line("Number of passenger inside the car:");
            Put_Line(TeslaCar.NumberOfPassengers'Image);
         when '4' =>
            Put_Line("OffLoading a passenger...");
            RemovePassenger;
            Put_Line("Number of passenger inside the car:");
            Put_Line(TeslaCar.NumberOfPassengers'Image);
         when '5' =>
            Put_Line("TrainType: ");
         when '6' =>
            Put_Line("TrainType: ");
         when '7' =>
            Put_Line("Enabling diagnostic mode... ");
            EnableDiagosticMode;
            Put_Line("Diagnostic mode:");
            Put_Line(TeslaCar.MaintenanceMode'Image);
         when '8' =>
            Put_Line("Disabling diagnostic mode...");
            DisableDiagosticMode;
            Put_Line("Diagnostic mode:");
            Put_Line(TeslaCar.MaintenanceMode'Image);
         when '9' =>
            Put_Line("Maintenance: ");
         when '+' =>
            Put_Line("TrainType: ");
         when '-' =>
            Put_Line("TrainType: ");
         when others => exit;
         end case;
      end loop;
      delay 0.1;
   end Start;


begin
   null;
end Main;
