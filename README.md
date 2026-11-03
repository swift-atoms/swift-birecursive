# swift-birecursive

Use this package when a recursive enum should be both folded and unfolded, that is, both `@Recursive` and `@Corecursive` over its `@FunctorBase`. Start from the `@Birecursive` macro: put it on the namespace that holds the recursive enums, and it adds all three prerequisites to each nested enum. When only one direction is needed, use `@Recursive` from swift-recursive or `@Corecursive` from swift-corecursive directly.

## Laws

- `@Birecursive` goes on the enclosing namespace, never on the recursive enum: a namespace that itself declares enum cases is rejected.
- Every enum nested directly in the namespace receives `@FunctorBase`, `@Recursive` and `@Corecursive`. An attribute already written on that enum under the same name is not added again; members that are not enums are left untouched.
- Nested enums that refer to each other in a cycle (mutual recursion) are rejected; each enum may only refer to itself.
- `embed` undoes `project`: embedding a projected value gives back the original value, for the base case and for deeply nested values alike.
