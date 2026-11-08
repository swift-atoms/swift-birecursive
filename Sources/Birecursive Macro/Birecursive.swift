public import Corecursive_Macro
public import Functor_Base_Macro
public import Recursive_Macro

@attached(memberAttribute)
public macro Birecursive() = #externalMacro(module: "Birecursive_Macro_Plugin", type: "Macro")
