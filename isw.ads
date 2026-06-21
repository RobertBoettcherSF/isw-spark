-- Version: 0.08
pragma SPARK_Mode;

package ISW is
   -- The fast algorithm uses a binary tree where leaves correspond to alphabet 
   -- symbols and parent nodes contain the sum of their children's frequencies.
   -- Num_Leaves should be the smallest power of 2 that is >= M.
   
   -- Maximum tree size to prevent overflow
   Max_Tree_Size : constant Positive := 1073741823;
   
   type Tree_Array is array (Positive range <>) of Natural;

   type Window_State(Num_Leaves : Positive; M : Positive) is record
      -- A complete binary tree represented as an array.
      -- Size is 2*Num_Leaves - 1, but we use Max_Tree_Size as upper bound for SPARK
      Tree    : Tree_Array(1 .. Max_Tree_Size) := (others => 0);
      Total_W : Natural := 0;
   end record
     with Dynamic_Predicate => M <= Num_Leaves and then 
                               Num_Leaves <= Max_Tree_Size and then
                               2 * Num_Leaves - 1 <= Max_Tree_Size;

   -- Finds the leaf corresponding to the randomly generated value R in O(log M)
   function Select_Index_To_Decrement(State : Window_State; R : Positive) return Positive
     with Pre  => State.Total_W > 0 and then
                   State.Total_W <= State.Tree(1),
          Post => Select_Index_To_Decrement'Result in 1 .. State.M;

   -- Updates the tree frequencies in O(log M) by traversing from leaf to root
   procedure Update_Window(State              : in out Window_State; 
                           Index_To_Increment : Positive;
                           Index_To_Decrement : Positive)
     with Pre => Index_To_Increment in 1 .. State.M and then
                 Index_To_Decrement in 1 .. State.M and then
                 State.Tree(State.Num_Leaves + Index_To_Decrement - 1) > 0;
end ISW;
