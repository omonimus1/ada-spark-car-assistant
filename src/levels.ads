package Levels with SPARK_Mode

-- specification file
is
   type Power is (On, Off);

   type Engine is record
      PowerLevel: Power;
   end record;

   TeslaCar : Engine := (PowerLevel=> Off);


   procedure plugIn with
     Global => (In_Out => TeslaCar),
     Pre => (TeslaCar.PowerLevel = Off),
     Post => TeslaCar.PowerLevel = On;


end Levels;
