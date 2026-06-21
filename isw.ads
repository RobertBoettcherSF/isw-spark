-- Version: 0.06
pragma SPARK_Mode;

package ISW is
   -- The fast algorithm uses a binary tree where leaves correspond to alphabet 
   -- symbols and parent nodes contain the sum of their children's frequencies.
   -- Num_Leaves should be the smallest power of 2 that is >= M.
   type Tree_Array(Size : Positive) is array (1 .. Size) of Natural;

   type Window_State(Num_Leaves : Positive; M : Positive) is record
      -- A complete binary tree represented as an array of size 2*Num_Leaves - 1.
      -- Root is at index 1. Leaves are at Num_Leaves .. 2*Num_Leaves - 1.
      Tree    : Tree_Array(2 * Num_Leaves - 1) := (others => 0);
      Total_W : Natural := 0;
   end record
     with Dynamic_Predicate => M <= Num_Leaves and then 
                               Num_Leaves <= 1073741823; -- Prevents index overflow

   -- Finds the leaf corresponding to the randomly generated value R in O(log M)
   function Select_Index_To_Decrement(State : Window_State; R : Positive) return Positive
     with Pre  => State.Total_W > 0,
          Post => Select_Index_To_Decrement'Result in 1 .. State.M;

   -- Updates the tree frequencies in O(log M) by traversing from leaf to root
   procedure Update_Window(State              : in out Window_State; 
                           Index_To_Increment : Positive;
                           Index_To_Decrement : Positive)
     with Pre => Index_To_Increment in 1 .. State.M and then
                 Index_To_Decrement in 1 .. State.M;
end ISW;
