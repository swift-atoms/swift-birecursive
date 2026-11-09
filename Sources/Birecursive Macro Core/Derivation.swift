public import SwiftSyntax

public enum Derivation {}

extension Derivation {
    /// The prerequisite attributes not yet written on the enum, matched on the
    /// attribute's last name component so `@Functor_Base_Macro.FunctorBase`
    /// counts as `@FunctorBase`.
    public static func attributes(existing: AttributeListSyntax) -> [AttributeSyntax] {
        let present = Set(existing.compactMap { $0.as(AttributeSyntax.self).map(name) })
        return ["FunctorBase", "Recursive", "Corecursive"].filter { !present.contains($0) }.map {
            AttributeSyntax(attributeName: IdentifierTypeSyntax(name: .identifier($0)))
        }
    }

    static func name(_ attribute: AttributeSyntax) -> String {
        if let member = attribute.attributeName.as(MemberTypeSyntax.self) {
            return member.name.text
        }
        if let identifier = attribute.attributeName.as(IdentifierTypeSyntax.self) {
            return identifier.name.text
        }
        return attribute.attributeName.trimmedDescription
    }
}
