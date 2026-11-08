import Corecursive_Macro
import Functor_Base_Macro
import Recursive_Macro

@attached(memberAttribute)
public macro Birecursive() = #externalMacro(module: "Birecursive_Macro_Plugin", type: "Macro")
