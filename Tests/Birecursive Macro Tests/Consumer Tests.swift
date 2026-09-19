import Birecursive_Macro
import Testing

@Birecursive
private enum Domain {
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
