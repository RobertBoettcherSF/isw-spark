-- Version: 0.06
pragma SPARK_Mode;

package body ISW is

   function Select_Index_To_Decrement(State : Window_State; R : Positive) return Positive is
      Current     : Positive := 1;
      Remaining_R : Positive := R;
      Left_Child  : Positive;
      Result_Idx  : Integer;
   begin
      -- Traverse down from root to a leaf based on frequency weights
      while Current < State.Num_Leaves loop
         pragma Loop_Invariant (Current >= 1 and Current < State.Num_Leaves);
         pragma Loop_Invariant (Remaining_R >= 1);
         pragma Loop_Invariant (Current <= Max_Tree_Size);
         pragma Loop_Variant (Increases => Current);
         
         Left_Child := 2 * Current;
         
         if Remaining_R <= State.Tree (Left_Child) then
            -- Go left
            Current := Left_Child;
         else
            -- Go right and deduct the left child's weight from R
            if Remaining_R > State.Tree (Left_Child) then
               Remaining_R := Remaining_R - State.Tree (Left_Child);
            end if;
            Current := Left_Child + 1;
         end if;
      end loop;

      -- Map the tree leaf index back to the alphabet symbol index
      Result_Idx := Current - State.Num_Leaves + 1;
      
      -- In a perfectly maintained sum-tree, R will only route to valid symbols.
      -- Bounding check mathematically guarantees the Post condition for the prover.
      if Result_Idx >= 1 and then Result_Idx <= State.M then
         return Result_Idx;
      else
         return 1; 
      end if;
   end Select_Index_To_Decrement;


   procedure Update_Window(State              : in out Window_State; 
                           Index_To_Increment : Positive;
                           Index_To_Decrement : Positive) is
      
      Dec_Node : Natural := State.Num_Leaves + Index_To_Decrement - 1;
      Inc_Node : Natural := State.Num_Leaves + Index_To_Increment - 1;
   begin
      -- 1. Propagate Decrement up the tree
      while Dec_Node >= 1 loop
         pragma Loop_Invariant (Dec_Node >= 1 and Dec_Node <= 2 * State.Num_Leaves - 1);
         pragma Loop_Invariant (Dec_Node <= Max_Tree_Size);
         pragma Loop_Variant (Decreases => Dec_Node);
         
         if State.Tree (Dec_Node) > 0 then
            State.Tree (Dec_Node) := State.Tree (Dec_Node) - 1;
         end if;
         Dec_Node := Dec_Node / 2;
      end loop;

      -- 2. Propagate Increment up the tree
      while Inc_Node >= 1 loop
         pragma Loop_Invariant (Inc_Node >= 1 and Inc_Node <= 2 * State.Num_Leaves - 1);
         pragma Loop_Invariant (Inc_Node <= Max_Tree_Size);
         pragma Loop_Variant (Decreases => Inc_Node);
         
         if State.Tree (Inc_Node) < Natural'Last then
            State.Tree (Inc_Node) := State.Tree (Inc_Node) + 1;
         end if;
         Inc_Node := Inc_Node / 2;
      end loop;
      
   end Update_Window;

end ISW;
