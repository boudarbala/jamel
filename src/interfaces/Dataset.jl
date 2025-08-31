"""
    Dataset

Abstract type representing a dataset.
This is the Julia equivalent of the Java Dataset interface.
"""
abstract type Dataset end

"""
    clear!(dataset::Dataset)

Removes all data from this dataset.
"""
function clear!(dataset::Dataset)
    error("clear! not implemented for $(typeof(dataset))")
end

"""
    get_data(dataset::Dataset, index::Int)

Returns the value of the specified data by index.
"""
function get_data(dataset::Dataset, index::Int)
    error("get_data not implemented for $(typeof(dataset))")
end

"""
    get_data(dataset::Dataset, key::String)

Returns the value of the specified data by key.
"""
function get_data(dataset::Dataset, key::String)
    error("get_data not implemented for $(typeof(dataset))")
end

"""
    put!(dataset::Dataset, key::String, value::Float64)

Stores a value associated with the specified key.
"""
function put!(dataset::Dataset, key::String, value::Float64)
    error("put! not implemented for $(typeof(dataset))")
end

"""
    put!(dataset::Dataset, key::String, value::Int)

Stores an integer value associated with the specified key.
"""
function put!(dataset::Dataset, key::String, value::Int)
    put!(dataset, key, Float64(value))
end

"""
    size(dataset::Dataset)

Returns the size of the dataset.
"""
function Base.size(dataset::Dataset)
    error("size not implemented for $(typeof(dataset))")
end