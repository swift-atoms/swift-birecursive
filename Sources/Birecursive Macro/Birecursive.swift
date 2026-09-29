@_exported import Functor_Base_Macro
@_exported import Recursive_Macro
@_exported import Corecursive_Macro
@attached(memberAttribute)
public macro Birecursive() = #externalMacro(module: "Birecursive_Macro_Plugin", type: "Macro")
