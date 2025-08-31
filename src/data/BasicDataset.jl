"""
    BasicDataset

A basic implementation of Dataset using an array of Float64.
This is the Julia equivalent of the Java BasicDataset class.
"""
mutable struct BasicDataset <: Dataset
    data::Vector{Union{Float64, Nothing}}
    keys::DataKeys
    agent::Union{Agent, Nothing}
    period::Int
    
    function BasicDataset(keys::DataKeys, agent::Union{Agent, Nothing}=nothing, period::Int=0)
        data = Vector{Union{Float64, Nothing}}(nothing, get_size(keys))
        new(data, keys, agent, period)
    end
end

"""
    clear!(dataset::BasicDataset)

Removes all data from this dataset.
"""
function clear!(dataset::BasicDataset)
    fill!(dataset.data, nothing)
end

"""
    get_data(dataset::BasicDataset, index::Int)

Returns the value of the specified data by index.
"""
function get_data(dataset::BasicDataset, index::Int)
    if index < 1 || index > length(dataset.data)
        return nothing
    end
    return dataset.data[index]
end

"""
    get_data(dataset::BasicDataset, key::String)

Returns the value of the specified data by key.
"""
function get_data(dataset::BasicDataset, key::String)
    if !has_key(dataset.keys, key)
        return nothing
    end
    index = get_index(dataset.keys, key)
    return get_data(dataset, index)
end

"""
    put!(dataset::BasicDataset, key::String, value::Float64)

Stores a value associated with the specified key.
"""
function put!(dataset::BasicDataset, key::String, value::Float64)
    index = get_index(dataset.keys, key)
    
    # Expand data array if necessary
    while length(dataset.data) < index
        push!(dataset.data, nothing)
    end
    
    dataset.data[index] = value
end

"""
    size(dataset::BasicDataset)

Returns the size of the dataset.
"""
Base.size(dataset::BasicDataset) = (length(dataset.data),)

"""
    get_period(dataset::BasicDataset)

Returns the period of this dataset.
"""
get_period(dataset::BasicDataset) = dataset.period

"""
    get_agent(dataset::BasicDataset)

Returns the agent associated with this dataset.
"""
get_agent(dataset::BasicDataset) = dataset.agent