-- Version: 0.02
# isw-spark
An implementation of the Imaginary Sliding Window (ISW) data structure in Ada SPARK. Uses a binary tree-based approach for efficient frequency tracking. Provides a memory-efficient alternative to traditional sliding windows for adaptive algorithms, maintaining source statistics via a frequency tree without storing the full window history.

## Verification
All SPARK proofs pass at level 4 with `--no-inlining`:
- All index checks proved
- All range checks proved  
- All overflow checks proved
- All loop invariants and variants proved
- Termination proved
