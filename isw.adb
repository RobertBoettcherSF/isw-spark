package body ISW is
   procedure Update_Window(State : in out Window_State; 
                           Index_To_Increment : Positive;
                           Random_Index_To_Decrement : Positive) is
   begin
      -- Standard ISW update rule: increment current letter, 
      -- decrement random letter coordinate.
      State.Freqs(Random_Index_To_Decrement) := State.Freqs(Random_Index_To_Decrement) - 1;
      State.Freqs(Index_To_Increment) := State.Freqs(Index_To_Increment) + 1;
   end Update_Window;
end ISW;
