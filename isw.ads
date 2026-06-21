-- Version: 0.04
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
     with Pre => Index_To_Increment in 1 .. State.M and then
                 Random_Index_To_Decrement in 1 .. State.M and then
                 State.Freqs(Random_Index_To_Decrement) > 0 and then
                 State.Freqs(Index_To_Increment) < Natural'Last;
end ISW;
