import Birecursive_Macro
import Testing

@Birecursive
private enum Domain {
    @FunctorBase
    @Recursive
    indirect enum Natural {
        case zero
        case successor(Natural)
    }
}
private typealias Natural = Domain.Natural

@Test
func `birecursive project and embed are inverse`() {
    let original = Natural.successor(.zero)
    let roundTrip = Natural.embed(original.project())
    guard case .successor(.zero) = roundTrip else {
        Issue.record("Expected project-embed round trip")
        return
    }
}

// A module-qualified prerequisite counts as present: were it added a second
// time, the duplicate `@FunctorBase` expansion would fail to compile.
@Birecursive
private enum Qualified {
    @Functor_Base_Macro.FunctorBase
    @Recursive_Macro.Recursive
    indirect enum Natural {
        case zero
        case successor(Natural)
    }
}

@Test
func `module-qualified prerequisites are not added twice`() {
    guard case .successor(.zero) = Qualified.Natural.embed(Qualified.Natural.successor(.zero).project())
    else {
        Issue.record("Expected project-embed round trip")
        return
    }
}
