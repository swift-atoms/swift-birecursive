import Birecursive_Macro
import Testing

@Birecursive
private enum Nested {
    indirect enum Count {
        case zero
        case successor(Count)
    }
}

@Suite
struct `Birecursive boundaries` {
    @Test
    func `the base case round trips through project and embed`() {
        guard case .zero = Nested.Count.embed(Nested.Count.zero.project()) else {
            Issue.record("Expected the base case back")
            return
        }
    }

    @Test
    func `a deep value keeps its outer layer through project and embed`() {
        let deep = (0..<100).reduce(Nested.Count.zero) { value, _ in .successor(value) }
        guard case .successor(.successor(_)) = Nested.Count.embed(deep.project()) else {
            Issue.record("Expected the outer layers back")
            return
        }
    }
}
