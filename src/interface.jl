#######################################################################################################################
#################################################### CRATE INTERFACE ##################################################
#######################################################################################################################

export Load, Destroy, getmanager, @crate

const JOIN_SYMBOL = '|'
#######################################################################################################################


macro crate(expr,args...)
    path_data = split(expr.args[1], JOIN_SYMBOL)
    path = joinpath(path_data...)
    T = expr.args[2]

    return :(Load!(getmanager(), $T, $path, ($args)...))
end

getmanager() = nothing
"""
    Load(T::Type{AbstractCrate}, args...)

Generic function to load a crate.
If this method doesn't exist for a given crate type then it will throw an error.
When adding a new crate type, you should overload this function.
"""
Load(T::Type{AbstractCrate}, args...) = error("Load not defined for crate of type $T. Could not load the crate.")

"""
    Destroy(crate::AbstractCrate)

Generic function to destroy a crate.
If this function doesn't exist for a given crate type then nothing happen and we will let the Julia's GC collect it.
When adding a new crate type, you should overload this function.
"""
Destroy(crate::AbstractCrate) = nothing