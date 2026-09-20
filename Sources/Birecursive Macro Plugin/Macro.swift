import Type_Algebra_Syntax
import Birecursive_Macro_Core
import SwiftSyntax
import SwiftSyntaxMacros
public struct Macro: MemberAttributeMacro {
    public static func expansion(of node: AttributeSyntax, attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [AttributeSyntax] {
        try Type.Syntax.Recursion.validateNamespace(declaration)
        if declaration.memberBlock.members.contains(where: { $0.decl.is(EnumCaseDeclSyntax.self) }) {
            throw MacroExpansionErrorMessage("@Birecursive attaches prerequisites to nested enums; apply it to their namespace, not to the recursive enum itself.")
        }
        guard let enumeration = member.as(EnumDeclSyntax.self) else { return [] }
        return Derivation.attributes(existing: Set(enumeration.attributes.compactMap { $0.as(AttributeSyntax.self)?.attributeName.trimmedDescription }))
    }
}
