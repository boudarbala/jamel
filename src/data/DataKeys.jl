"""
    DataKeys

Type for managing data keys and their corresponding indices.
This is the Julia equivalent of the Java DataKeys interface.
"""
mutable struct DataKeys
    keys_to_indices::Dict{String, Int}
    indices_to_keys::Dict{Int, String}
    next_index::Int
    
    DataKeys() = new(Dict{String, Int}(), Dict{Int, String}(), 1)
end

"""
    get_index(keys::DataKeys, key::String)

Returns the index for the specified key, creating it if it doesn't exist.
"""
function get_index(keys::DataKeys, key::String)
    if haskey(keys.keys_to_indices, key)
        return keys.keys_to_indices[key]
    else
        index = keys.next_index
        keys.keys_to_indices[key] = index
        keys.indices_to_keys[index] = key
        keys.next_index += 1
        return index
    end
end

"""
    get_key(keys::DataKeys, index::Int)

Returns the key for the specified index.
"""
function get_key(keys::DataKeys, index::Int)
    if haskey(keys.indices_to_keys, index)
        return keys.indices_to_keys[index]
    else
        error("Index not found: $(index)")
    end
end

"""
    has_key(keys::DataKeys, key::String)

Returns true if the specified key exists.
"""
has_key(keys::DataKeys, key::String) = haskey(keys.keys_to_indices, key)

"""
    get_size(keys::DataKeys)

Returns the number of keys.
"""
get_size(keys::DataKeys) = length(keys.keys_to_indices)