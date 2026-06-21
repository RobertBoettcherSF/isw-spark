-- Version: 0.03
pragma SPARK_Mode;

package ISW is
   -- Based on the ISW scheme requiring only the frequency vector
   -- for an alphabet of size M and window length W.
   type Frequency_Vector is array (Positive range <>) of Natural;

   type Window_State(M : Positive; W : Natural) is record
      Freqs : Frequency_Vector(1 .. M);
      Total_W : Natural := W;
   end record;

   procedure Update_Window(State : in out Window_State; 
                           Index_To_Increment : Positive;
                           Random_Index_To_Decrement : Positive)
     with Pre => Random_Index_To_Decrement <= State.M and 
                 State.Freqs(Random_Index_To_Decrement) > 0;
end ISW;
