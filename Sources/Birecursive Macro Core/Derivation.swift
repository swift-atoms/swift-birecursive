public import SwiftSyntax
public enum Derivation {
    public static func attributes(existing: Set<String>) -> [AttributeSyntax] {
        ["FunctorBase", "Recursive", "Corecursive"].filter { !existing.contains($0) }.map {
            AttributeSyntax(attributeName: IdentifierTypeSyntax(name: .identifier($0)))
        }
    }
}
