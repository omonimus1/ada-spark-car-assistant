package borst with SPARK_Mode
is
   --Rules:
   --There must always be at least 1 control rod in the reactor
   --Engine Temp should stay below 2200 deg C, anything above shuts down the engine
   --Max of 10 Carriages not including engine
   --Speed in km/h
   --Water level
   --engine can only be on or off
   --Maintenance is added to with most actions

   type ControlRod is range 1..5;
   type EngineTemp is range 0..2500;
   type Speed is range 0..250;
   type Level is range 0..10;
   type Power is (On, Off);
   type LastMaintained is range 0..100;
   type Light is (GREEN, AMBER, RED);
   type CarType is (FREIGHT, PASSENGER);
   type Mass is range 190..1700;
   type NumCarriages is range 0..10;
   type FreightWeight is range 0..1100;
   type PassengerCount is range 0..1000;

   type Carriage (Typtr : CarType := FREIGHT) is record
      Cars : NumCarriages;
      MaxSpeed : Speed;
      Weight : Mass;
      case Typtr is
         when FREIGHT => Cargo : FreightWeight;
         when PASSENGER => Voyagers : PassengerCount;
      end case;
   end record;

   type Engine is record
      Rods : ControlRod;
      Powered : Power;
      WaterTank : Level;
      Heat : EngineTemp;
      Maintenance : LastMaintained;
      MtnLight : Light;
      HeatLight : Light;
      WaterLight : Light;
   end record;

   type Train is record
      TrainType : CarType;
      Generator : Engine;
      Cart : Carriage;
      CurSpeed : Speed;
   end record;

   BorstMobile : Train := (TrainType=>PASSENGER,
                           Cart=>(Typtr=>PASSENGER,
                                  Cars=>NumCarriages'First,
                                  MaxSpeed=>Speed'First,
                                  Weight=>Mass(Integer(Mass'First)+Integer(Level'Last)),
                                  Voyagers=>PassengerCount'First),
                           Generator=>(Rods=>ControlRod'Last,
                                       Powered=>Off,
                                       WaterTank=>Level'Last,
                                       Heat=>EngineTemp'First,
                                       Maintenance=>LastMaintained'First,
                                       MtnLight=>GREEN,
                                       HeatLight=>GREEN,
                                       WaterLight=>GREEN
                                      ),
                           CurSpeed=>Speed'First);


   procedure AddRod with
     Global=> (In_Out =>BorstMobile),
     Depends => (BorstMobile=>BorstMobile),
     Pre=>BorstMobile.Generator.Rods<ControlRod'Last and
     BorstMobile.Generator.Maintenance < LastMaintained'Last and
     BorstMobile.Generator.WaterTank > Level'First and
     BorstMobile.Generator.Powered = On,
     Post=>(BorstMobile.Generator.Powered = On);

   procedure RemoveRod with
     Global=> (In_Out =>BorstMobile),
     Depends => (BorstMobile=>BorstMobile),
     Pre=>(BorstMobile.Generator.Rods>ControlRod'First and
     BorstMobile.Generator.Powered = On and
     BorstMobile.Generator.Maintenance < (LastMaintained'Last-10) and
     BorstMobile.Generator.WaterTank > Level'First),
     Post=>(BorstMobile.Generator.Powered = On);

   procedure DoMaintenance with
     Global=> (In_Out =>BorstMobile),
     Depends => (BorstMobile=>BorstMobile),
     Pre=> BorstMobile.Generator.Powered = Off and BorstMobile.Generator.Rods = ControlRod'Last and
     BorstMobile.CurSpeed = Speed'First and BorstMobile.Generator.Heat = EngineTemp'First,
     Post=> BorstMobile.Generator.Powered = Off and BorstMobile.Generator.Maintenance = LastMaintained'First and BorstMobile.Generator.WaterTank =Level'Last;


   procedure StartEngine with
     Global=> (In_Out =>BorstMobile),
     Depends => (BorstMobile=>BorstMobile),
     Pre=> BorstMobile.Generator.Powered = Off and BorstMobile.Generator.Rods = ControlRod'Last and
     BorstMobile.CurSpeed = Speed'First,
     Post=>BorstMobile.Generator.Powered=On;

   procedure StopEngine with
     Global=> (In_Out =>BorstMobile),
     Depends => (BorstMobile=>BorstMobile),
     Pre => BorstMobile.Generator.Powered = On,
     Post=> BorstMobile.Generator.Powered = Off and BorstMobile.CurSpeed = Speed'First;

   procedure AddTrainCar with
     Global=> (In_Out =>BorstMobile),
     Depends => (BorstMobile=>BorstMobile),
     Pre=>BorstMobile.CurSpeed = Speed'First and BorstMobile.Cart.Cars < NumCarriages'Last,
     Post=>BorstMobile.Cart.Cars<=NumCarriages'Last;

   procedure RemoveTrainCar with
     Global=> (In_Out =>BorstMobile),
     Pre=>BorstMobile.CurSpeed = Speed'First and BorstMobile.Cart.Cars < NumCarriages'First,
     Post=>BorstMobile.Cart.Cars>=NumCarriages'Last;

   function GetMax (num : NumCarriages) return Speed with
     Post=>GetMax'Result<=200 and GetMax'Result>=100;

   function GetHeat (water : Level; rods : ControlRod) return EngineTemp with
     Post=>GetHeat'Result<=EngineTemp'Last;

   function GetCurrentSpeed (car : Mass; heat : EngineTemp) return Speed with
     Post=>GetCurrentSpeed'Result<=Speed'Last and GetCurrentSpeed'Result>=Speed'First;

   procedure EmergencyStop with
     Global=>(In_Out => BorstMobile),
     Pre=>(BorstMobile.Generator.Powered = On)
   ;
   procedure HeatL with
     Global=> (In_Out => BorstMobile),
     Pre=>BorstMobile.Generator.Powered = On,
     Post=>(BorstMobile.Generator.HeatLight=GREEN or BorstMobile.Generator.HeatLight=AMBER or
              BorstMobile.Generator.HeatLight = RED);

   procedure FillTank with
     Global=>(In_Out => BorstMobile),
     Pre=>BorstMobile.CurSpeed = Speed'First,
     Post=> BorstMobile.Generator.WaterTank = Level'Last;

   procedure TankL with
     Global=>(In_Out => BorstMobile),
     Pre=>BorstMobile.Generator.WaterTank>Level'First and BorstMobile.Generator.Powered = On,
     Post=> BorstMobile.Generator.WaterTank=BorstMobile.Generator.WaterTank'Old-1;

   procedure MaintL with
     Global=>(In_Out => BorstMobile),
     Pre=>BorstMobile.Generator.Powered=On and BorstMobile.Generator.Maintenance<LastMaintained'Last,
     Post=>BorstMobile.Generator.Maintenance=BorstMobile.Generator.Maintenance'Old+1;

   procedure SpeedL with
     Global=> (In_Out=>BorstMobile),
     Pre=>BorstMobile.Generator.Maintenance<LastMaintained'Last and
     BorstMobile.Generator.WaterTank > Level'First and BorstMobile.Generator.Powered = On;


   procedure ChangeCarriageType with
     Global=>(In_Out=>BorstMobile),
     Pre=>BorstMobile.Cart.Cars=NumCarriages'First and BorstMobile.CurSpeed = Speed'First,
     Post=> BorstMobile.TrainType = BorstMobile.Cart.Typtr and BorstMobile.TrainType /= BorstMobile.TrainType'Old;

   procedure AddPassenger with
     Global=>(In_Out=>BorstMobile),
     Depends=>(BorstMobile=>BorstMobile),
     Pre=>BorstMobile.TrainType = PASSENGER and BorstMobile.Cart.Typtr = PASSENGER
     and BorstMobile.Cart.Cars>NumCarriages'First
     and BorstMobile.Cart.Voyagers < PassengerCount'Last and
     Integer(BorstMobile.Cart.Voyagers) < (Integer(PassengerCount'Last) * (Integer(BorstMobile.Cart.Cars)/Integer(NumCarriages'Last))) and
     BorstMobile.CurSpeed = Speed'First,
     Post=>Integer(BorstMobile.Cart.Voyagers) <= (Integer(PassengerCount'Last) * (Integer(BorstMobile.Cart.Cars)/Integer(NumCarriages'Last)));

   procedure RemovePassenger with
     Global=>(In_Out=>BorstMobile),
     Depends=>(BorstMobile=>BorstMobile),
     Pre=>BorstMobile.TrainType=PASSENGER and BorstMobile.Cart.Typtr = PASSENGER and
     BorstMobile.Cart.Voyagers > PassengerCount'First
     and BorstMobile.CurSpeed = Speed'First,
     Post=>BorstMobile.Cart.Voyagers <= BorstMobile.Cart.Voyagers'Old and BorstMobile.Cart.Voyagers >= PassengerCount'First;

   procedure AddFreight with
     Global=>(In_Out=>BorstMobile),
     Depends=>(BorstMobile=>BorstMobile),
     Pre=>(BorstMobile.TrainType=FREIGHT  and BorstMobile.Cart.Typtr=FREIGHT
     and BorstMobile.Cart.Cars>NumCarriages'First
     and BorstMobile.Cart.Cargo < FreightWeight'Last and
     BorstMobile.CurSpeed = Speed'First and
     Integer(BorstMobile.Cart.Cargo) < (Integer(FreightWeight'Last) * (Integer(BorstMobile.Cart.Cars)/Integer(NumCarriages'Last)))),
     Post=>Integer(BorstMobile.Cart.Cargo) > Integer(BorstMobile.Cart.Cargo'Old) and BorstMobile.TrainType=FREIGHT  and BorstMobile.Cart.Typtr=FREIGHT;

   procedure RemoveFreight with
     Global=>(In_Out=>BorstMobile),
     Depends=>(BorstMobile=>BorstMobile),
     Pre=>BorstMobile.TrainType=FREIGHT and BorstMobile.Cart.Typtr = FREIGHT
     and BorstMobile.Cart.Cargo > FreightWeight'First
     and BorstMobile.CurSpeed = Speed'First,
     Post=>BorstMobile.Cart.Cargo = BorstMobile.Cart.Cargo'Old-1 and BorstMobile.Cart.Cargo >= FreightWeight'First and BorstMobile.TrainType=FREIGHT  and BorstMobile.Cart.Typtr=FREIGHT;


   function CalcWeight (wat : Level; car : Carriage) return Mass with
     Post=>CalcWeight'Result<=Mass'Last;
end borst;
