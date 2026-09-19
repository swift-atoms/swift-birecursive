@_exported import Functor_Base_Macro
@_exported import Recursive_Macro
@_exported import Corecursive_Macro
/// Installs the two directions and their shared base on direct enum members.
@attached(memberAttribute)
public macro Birecursive() = #externalMacro(module: "Birecursive_Macro_Plugin", type: "Macro")
