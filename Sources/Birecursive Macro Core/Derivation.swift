import Corecursive_Macro_Core
import Recursive_Macro_Core
public import SwiftSyntax

public enum Derivation {
    public static func expansion(of declaration: EnumDeclSyntax) -> [DeclSyntax] {
        Recursive_Macro_Core.Derivation.expansion(of: declaration)
            + Corecursive_Macro_Core.Derivation.operation(of: declaration)
    }
}
